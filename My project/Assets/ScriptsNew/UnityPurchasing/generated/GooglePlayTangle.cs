// WARNING: Do not modify! Generated file.

namespace UnityEngine.Purchasing.Security {
    public class GooglePlayTangle
    {
        private static byte[] data = System.Convert.FromBase64String("kgkrPtNG8rKbREm88WjDbtTt3BPycX9wQPJxenLycXFw0VQZhRED2A+rgfmqvvONDBq4s/KRsB7Mn49gCPNyFQZoClYJISu46Ysxj8+JyQEta+UWt7BOXYmfcsT0ec8RBepxzKK22doXaTSppzd+MGHWGF7FIjKV4IhDgwzgL8yTRvvoGk9529uYWzFqgTqsSfbshuwiVDbu15JVWOkiv0DycVJAfXZ5WvY49od9cXFxdXBzQx2AT9BiJQrX3lLGpvdsebaQfU5xbSz8tC0htep/3yShhq0Vbu7Gs9grylLkg+whwVyI9vHgnUAUvu5fQXUrGqtPc2IS981jzfTqbzPSaBcUzBzWDaC1WqikzcJMpmNR59MDAjJEMm6SFBPhD3JzcXBx");
        private static int[] order = new int[] { 2,1,9,3,10,5,10,12,9,12,12,11,12,13,14 };
        private static int key = 112;

        public static readonly bool IsPopulated = true;

        public static byte[] Data() {
        	if (IsPopulated == false)
        		return null;
            return Obfuscator.DeObfuscate(data, order, key);
        }
    }
}
