namespace Ax_islTofRegDrv
{
    unsafe public partial class Cio : Iio
    {
        // implementation
        public void setDrvApi(int fpApi) { dll.cSetDrvApi(fpApi); }
        public void readField(int a, byte s, byte m, byte* d) { dll.cReadField(a, s, m, d); }
        public void writeField(int a, byte s, byte m, byte d) { dll.cWriteField(a, s, m, d); }
        public void readByte(int a, byte* d) { dll.cReadByte(a, d); }
        public void writeByte(int a, byte d) { dll.cWriteByte(a, d); }
        public void readWord(int a, int* d) { dll.cReadWord(a, d); }
        public void writeWord(int a, int d) { dll.cWriteWord(a, d); }
    }
}
