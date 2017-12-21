using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace Edgar.DriveSpace
{
    /// <summary>
    /// Prints DriveInfo list to the console
    /// </summary>
    public class ConsolePrinter
    {
        #region COLORS AND VALUES
        public ConsoleColor DangerColor { get; set; } = ConsoleColor.Red;
        public ConsoleColor WarningColor { get; set; } = ConsoleColor.Yellow;
        public ConsoleColor OkColor { get; set; } = ConsoleColor.Green;

        public int OkPercentage { get; set; } = 50;
        public int WarninPercentage { get; set; } = 75;

        public ConsoleColor DangerSymbolColor { get; set; } = ConsoleColor.Red;
        public int DangerSymbolPercentage { get; set; } = 95;
        #endregion

        private readonly IEnumerable<DriveInfo> _drives;
        private readonly OS _os;
        private readonly ConsoleColor _defaultFg;
        private readonly ConsoleColor _defaultBg;

        private int _maxMountStringSize = 20;
        private int _maxPercentStringSize = 5;
        private int _maxDriveSizeStringSize = 7;
        private int _barStringSize = 20;

        public ConsolePrinter(IEnumerable<DriveInfo> drives, OS os)
        {
            _defaultFg = Console.ForegroundColor;
            _defaultBg = Console.BackgroundColor;
            _drives = drives;
            _os = os;
        }

        private int GetLineWidthInChars()
        {
            return
                _maxMountStringSize
                + _maxDriveSizeStringSize * 2
                + 3 // for divider " / "
                + _barStringSize
                + 3 // bar ![]
                + _maxPercentStringSize + 1;
        }

        public void Print()
        {
            var largestMountNameLength = _drives.Max(x => x.Name.Length);
            var newLineWidth = GetLineWidthInChars() - _maxMountStringSize + largestMountNameLength;

            if (newLineWidth + 1 < Console.WindowWidth && largestMountNameLength > _maxMountStringSize)
                _maxMountStringSize = largestMountNameLength+1;

            foreach (var drive in _drives)
                PrintDriveInfo(drive);
        }

        private void PrintDriveInfo(DriveInfo drive)
        {
            var normalizedPercentUsed = 1 - (drive.TotalFreeSpace / (double)drive.TotalSize);
            var percentUsed = MakePercentageString(normalizedPercentUsed).PadLeft(_maxPercentStringSize, ' ');

            PrintMountString(drive);
            PrintSizeUsed(drive);
            Console.Write(" / ");
            PrintSizeTotal(drive);
            PrintBar((int)(normalizedPercentUsed * 100));
            Console.WriteLine($" {percentUsed}%");
        }

        private void PrintBar(int percentageFull)
        {
            if (percentageFull >= DangerSymbolPercentage)
            {
                Console.ForegroundColor = DangerSymbolColor;
                Console.Write("!");
                ResetColor();
            }
            else
                Console.Write(" "); // leave empty space to keep formatting

            var step = 100 / _barStringSize;
            var bars = percentageFull / step;
            Console.Write("[");
            for (var i = 0; i < _barStringSize; i++)
            {
                if (i < bars)
                {
                    var p = i / (double)_barStringSize * 100; // percentage of current bar
                    var color = (p <= OkPercentage) ? OkColor 
                              : (p <= WarninPercentage) ? WarningColor 
                              : DangerColor;
                    Console.ForegroundColor = color;
                    Console.Write("|");
                    ResetColor();
                }
                else
                    Console.Write(" ");
            }

            Console.Write("]");
        }

        private string MakeSizeString(double sizeBytes, int bytesPerKb = 1024)
        {
            string[] labels = { "B", "K", "M", "G", "T" };
            var index = 0;
            var len = sizeBytes;
            while (len >= bytesPerKb && index < labels.Length - 1)
            {
                index++;
                len = len / bytesPerKb;
            }
            var result = $"{len:0.#}{labels[index]}";
            return result;
        }

        private string MakePercentageString(double normalizedPercentage)
        {
            var p = normalizedPercentage * 100;
            if (p < 100)
                p = Math.Round(p, 1);
            else
                p = Math.Round(p);
            return p.ToString("F1", CultureInfo.InvariantCulture);
        }

        private void ResetColor()
        {
            Console.ForegroundColor = _defaultFg;
            Console.BackgroundColor = _defaultBg;
        }

        private void PrintMountString(DriveInfo drive)
        {
            string mount;
            if (_os == OS.Windows)
                mount = $"{drive.RootDirectory.FullName}({drive.VolumeLabel.CutEnd(_maxMountStringSize)})"
                        .PadRight(_maxMountStringSize, ' ');
            else
                mount = drive
                    .RootDirectory
                    .FullName
                    .CutEnd(_maxMountStringSize)
                    .PadRight(_maxMountStringSize, ' ');

            Console.Write(mount);
        }

        private void PrintSizeUsed(DriveInfo drive)
        {
            var sizeUsed = MakeSizeString(drive.TotalSize - drive.TotalFreeSpace).PadLeft(_maxDriveSizeStringSize, ' ');
            Console.Write(sizeUsed);
        }

        private void PrintSizeTotal(DriveInfo drive)
        {
            var sizeTotal = MakeSizeString(drive.TotalSize).PadRight(_maxDriveSizeStringSize, ' ');
            Console.Write(sizeTotal);
        }
    }
}