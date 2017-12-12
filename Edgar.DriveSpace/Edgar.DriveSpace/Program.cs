using System.IO;
using System.Runtime.InteropServices;
using System.Linq;

namespace Edgar.DriveSpace
{
    public class Program
    {
        private static void Main()
        {
            var drives = DriveInfo
                .GetDrives()
                .Where(x=> x.IsReady && x.TotalSize > 0) // ignore partitions with no size
                .OrderBy(x => x.RootDirectory.FullName);

            var printer = new ConsolePrinter(drives, GetOS());
            printer.Print();
        }

        /// <summary>
        /// Returns OS enum based on IsOSPlatform result from the current runtime
        /// </summary>
        /// <returns>OS enum with current OS value or OS.Unknown if the check fails</returns>
        public static OS GetOS()
        {
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                return OS.Windows;
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                return OS.Linux;
            if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
                return OS.OsX;

            return OS.Unknown;
        }
    }
}
