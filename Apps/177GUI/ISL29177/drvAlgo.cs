using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using IntersilLib;

namespace ISL29177
{

    public class regAddr
    {
        public int value;
        public bool isVolatile;
        public regAddr()
        {
            value = 0;
            isVolatile = false;
        }
    }

    public class bitField
    {
        public int addr;
        public int mask;
        public int shift;
        public bitField()
        {
            addr = 0;
            mask = 1;
            shift = 0;
        }
    }

    enum fieldNames
    {
        SLP,
        POFF,
        POR0,
        POR1,
        PRX,
        TPLS,
        NFLDS
    }

    public class drvAlgo
    {
        regAddr[] registers;
        bitField[] fields;

        public drvAlgo()
        {
            int i;

            registers = new regAddr[0x10];
            for (i = 0; i < 0x10; i++)
                registers[i] = new regAddr();

            fields = new bitField[(int)fieldNames.NFLDS];
            for (i = 0; i < (int)fieldNames.NFLDS; i++)
                fields[i] = new bitField();

            writeByte(0x9, 0x89);// enable test mode
            writeByte(0xF, 0x40);// enable registers

            // load initial image
            for (i = 0; i <= 0x0F; i++)
                readByte(i,ref registers[i].value);

            i = (int)fieldNames.SLP;
            fields[i].addr = 0x01; fields[i].mask = 0x07; fields[i].shift = 4;

            i = (int)fieldNames.POFF;
            fields[i].addr = 0x02; fields[i].mask = 0x1F; fields[i].shift = 0;

            i = (int)fieldNames.POR0;
            fields[i].addr = 0x02; fields[i].mask = 0x01; fields[i].shift = 5;

            i = (int)fieldNames.POR1;
            fields[i].addr = 0x0E; fields[i].mask = 0x01; fields[i].shift = 2;

            i = (int)fieldNames.PRX;
            fields[i].addr = 0x07; fields[i].mask = 0xFF; fields[i].shift = 0;

            i = (int)fieldNames.TPLS;
            fields[i].addr = 0x02; fields[i].mask = 0x01; fields[i].shift = 6;

            writeField(fields[(int)fieldNames.TPLS], 1); // set to 3 pulse as default
        }

        void sleep(int time)
        {
            Thread.Sleep(time);
        }

        void writeByte(int addr, int data)
        {
            HIDClass.WriteSingleRegister((byte)data, 1, (byte)addr);
            registers[addr].value = data;
        }

        void readByte(int addr,ref int data)
        {
            HIDClass.ReadSingleRegister((byte)data, 1, (byte)addr);
            data = GlobalVariables.WriteRegs[addr];
            registers[addr].value = data;
        }

        void writeField(bitField bits, int data)
        {
            int addr = bits.addr, wdata=0;

            if (registers[addr].isVolatile) readByte(addr,ref wdata);

            wdata = registers[addr].value & (0xFF - (bits.mask << bits.shift)); // background
            wdata |= ( (data & bits.mask) << bits.shift );

            writeByte(addr, wdata);
        }

        void  readField(bitField bits,ref int data)
        {
            readByte(bits.addr,ref data);
            data = (data >> bits.shift) & bits.mask;
        }

        void setProxOffset(int tick)
        {
            int r0, r1, v;

            if (tick < 0)
            {
                tick = 0;
            }
            else
            {
                if (tick > 91)
                    tick = 91;
            }

            if (tick <= 31)
            {
                r0=0; r1=0; v=tick;
            }
            else
            {
                if (tick <= 49)
                {
                    r0 = 1; r1 = 0; v = tick - 18;
                }
                else
                {
                    if (tick <= 72)
                    {
                        r0 = 0; r1 = 1; v = tick - 41;
                    }
                    else
                    {
                        r0 = 1; r1 = 1; v = tick - 60;
                    }
                }
            }

            writeField(fields[(int)fieldNames.POR0], r0);
            writeField(fields[(int)fieldNames.POR1], r1);
            writeField(fields[(int)fieldNames.POFF], v);
        }

        int getProximity()
        {
            int data = 0;

            readField(fields[(int)fieldNames.PRX],ref data);

            return data;
        }

        public void adjustOffset()
        {
            int[] pTable = new int[13];
            int i=0;
    
            if (pTable[0] == 0)
            {
                pTable[i] = 30; i = i + 1; pTable[i] = 45; i = i + 1;
                pTable[i] = 53; i = i + 1; pTable[i] = 58; i = i + 1;
                pTable[i] = 63; i = i + 1; pTable[i] = 66; i = i + 1;
                pTable[i] = 69; i = i + 1; pTable[i] = 72; i = i + 1;
                pTable[i] = 74; i = i + 1; pTable[i] = 77; i = i + 1;
                pTable[i] = 79; i = i + 1; pTable[i] = 81; i = i + 1;
                pTable[i] = 82; i = i + 1;
            }

            int sleepTime=0, pOffset=0, prox=0;

            readField(fields[(int)fieldNames.SLP],ref sleepTime);
            writeField(fields[(int)fieldNames.SLP], 4); // 25ms

            setProxOffset(pOffset);
            sleep(25);
            prox=getProximity();

            for (i = 0; i <= 12; i++)
            {
                if (prox > 0x80)
                {
                    setProxOffset(pTable[i]);
                    sleep(25);
                    prox = getProximity();
                }
                else
                {
                    if (i > 0) pOffset = pTable[i-1];
                    break;
                }
            }

            while (prox > 5)
            {
                pOffset++;
                setProxOffset(pOffset);
                sleep(25);
                prox = getProximity();
                if (pOffset > 92) break;
            }

            while (prox < 1)
            {
                pOffset--;
                setProxOffset(pOffset);
                sleep(25);
                prox = getProximity();
                if (pOffset <= 0) break;
            }

            writeField(fields[(int)fieldNames.SLP], sleepTime);
        }

    }
}
