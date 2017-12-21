namespace Edgar.DriveSpace
{
    public static class StringExtensions
    {
        /// <summary>
        /// Cuts string if it is longer than defined maximum and adds ending symbols by default
        /// </summary>
        /// <param name="text">String to perform action on</param>
        /// <param name="maxLength">Absolute maximum length of the string including end symbols if any</param>
        /// <param name="endSymbolAmount">The amount of end symbols to add to end if string is too long. For example 2 will add ".." to the end</param>
        /// <param name="endSymbol">The symbol to replace ending with if string is too long</param>
        /// <returns>Original string if its less than or same as maxLength, otherwise cuts string down to maxLength</returns>
        public static string CutEnd(this string text, int maxLength, int endSymbolAmount = 2, char endSymbol = '.')
        {
            // no changes needed if string matches requirements
            if (text.Length <= maxLength)
                return text;

            var charBuffer = new char[maxLength];
            for (var i = 0; i < maxLength; i++)
            {
                if (maxLength - i <= endSymbolAmount)
                    charBuffer[i] = endSymbol;
                else
                    charBuffer[i] = text[i];
            }
            return new string(charBuffer);
        }
    }
}