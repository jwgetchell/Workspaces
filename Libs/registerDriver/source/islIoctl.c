/******************************************************************************
 * isl29015.h - Linux kernel module for Intersil ISL29015 ambient light sensor
 *				and proximity sensor
 *
 * Copyright 2008-2009 Intersil Inc..
 *
 * DESCRIPTION:
 *	- This is the linux driver for isl29015 and passed the test under the Linux
 *	Kernel version 2.6.30.4
 *
 * modification history
 * --------------------
 * v1.0   2009/11/03, Shouxian Chen(Simon Chen) create this file

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 ******************************************************************************/

#include <linux/module.h>
#ifdef stopHere
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/idr.h>
#include <linux/fs.h>
#include <linux/timer.h>
#include <linux/sched.h>
#include <linux/seq_file.h>
#include <asm/io.h>
#include <linux/ioctl.h>
#include <linux/types.h>
#include <linux/spinlock.h>
#include <asm/uaccess.h>
#include "islIoctl.h"


/* Do not scan isl29011 automatic */
static const unsigned short normal_i2c[] = {I2C_CLIENT_END };

/* force i2c addr */
static const unsigned short force[]= {
	ANY_I2C_BUS,ISL29011_ADDR,
	I2C_CLIENT_END};

static const unsigned short * const forces[] = {force, NULL};

/* Insmod parameters */
I2C_CLIENT_INSMOD_COMMON;

/* data struct for isl29011 device */
struct isl29011_data_t	isl29011_data = {
	.minor = 255, /* 255 indicated that isl29011 is not regsitered as device file*/
	.dev_open_cnt = 0,
	.client = NULL,
	.pwr_status = 0
};

static int isl29011_open(struct inode *inode, struct file *filp)
{
	u8 i_minor;

	i_minor = MINOR(inode->i_rdev);

	/* check open file conut */
	spin_lock(&isl29011_data.lock);
	if ( i_minor != isl29011_data.minor) goto no_dev_err;
	if ( isl29011_data.dev_open_cnt > 0) goto has_open_err;
	isl29011_data.dev_open_cnt++;
	spin_unlock(&isl29011_data.lock);

	filp->private_data = (void *)&isl29011_data;

	return 0;

no_dev_err:
	spin_unlock(&isl29011_data.lock);
	return -ENODEV;
has_open_err:
	spin_unlock(&isl29011_data.lock);
	return -EMFILE;
}

static int isl29011_close(struct inode *inode, struct file *filp)
{
	u8 i_minor;
	struct isl29011_data_t *p_data;

	p_data = (struct isl29011_data_t *)filp->private_data;
	i_minor = MINOR(inode->i_rdev);

	spin_lock(&(p_data->lock));
	if ( i_minor != p_data->minor) goto no_dev_err;
	if (p_data->dev_open_cnt > 0) p_data->dev_open_cnt--;
	spin_unlock(&(p_data->lock));

	/* power off the isl29011 */
	i2c_smbus_write_byte_data(isl29011_data.client, 0x00, 0x00);

	return 0;

no_dev_err:
	spin_unlock(&(p_data->lock));
	return -ENODEV;
}

static int isl29011_ioctl(struct inode *inode, struct file *filp,
	unsigned int cmd, unsigned long arg)
{
	void __user *argp = (void __user *)arg;
	u8 buf_8;
	u16 buf_16;
	s32	buf_32;
	int ret;
	struct isl29011_data_t *p_data;

	p_data = (struct isl29011_data_t *)filp->private_data;
	if (p_data == NULL) return -EFAULT;

	spin_lock(&(p_data->lock));
	switch (cmd)
	{
		case WR_CMD1:
			ret = get_user(buf_8, (u8 __user*)argp);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return -EFAULT;
			}
			ret = i2c_smbus_write_byte_data(p_data->client,0x00,buf_8);
			break;

		case WR_CMD2:
			ret = get_user(buf_8, (u8 __user*)argp);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return -EFAULT;
			}
			ret = i2c_smbus_write_byte_data(p_data->client,0x01,buf_8);
			break;

		case WR_INT_LT:
			ret = get_user(buf_16, (u16 __user*)argp);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return -EFAULT;
			}
			buf_8 = buf_16 & 0xff;
			ret = i2c_smbus_write_byte_data(p_data->client,0x04,buf_8);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return ret;
			}
			buf_8 = buf_16 >> 8;
			ret = i2c_smbus_write_byte_data(p_data->client,0x05,buf_8);
			break;

		case WR_INT_HT:
			ret = get_user(buf_16, (u16 __user*)argp);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return -EFAULT;
			}
			buf_8 = buf_16 & 0xff;
			ret = i2c_smbus_write_byte_data(p_data->client,0x06,buf_8);
			if (ret)
			{
				spin_unlock(&(p_data->lock));
				return ret;
			}
			buf_8 = buf_16 >> 8;
			ret = i2c_smbus_write_byte_data(p_data->client,0x07,buf_8);
			break;

		case RD_CMD1:
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x00);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			ret = put_user((u8)buf_32, (u8 __user*)argp);
			break;

		case RD_CMD2:
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x01);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			ret = put_user((u8)buf_32, (u8 __user*)argp);
			break;

		case RD_DATA:
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x02);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_32;
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x03);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_16 + (buf_32 << 8);
			ret = put_user(buf_16, (u16 __user*)argp);
			break;

		case RD_INT_LT:
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x04);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_32;
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x05);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_16 + (buf_32 << 8);
			ret = put_user(buf_16, (u16 __user*)argp);
			break;

		case RD_INT_HT:
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x06);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_32;
			buf_32 = i2c_smbus_read_byte_data(p_data->client,0x07);
			if(buf_32 < 0)
			{
				spin_unlock(&(p_data->lock));
				return buf_32;
			}
			buf_16 = buf_16 + (buf_32 << 8);
			ret = put_user(buf_16, (u16 __user*)argp);
			break;

		default:
			spin_unlock(&(p_data->lock));
			return -EINVAL;
	}
	spin_unlock(&(p_data->lock));

	return ret;
}

static struct file_operations isl29011_fops = {
	.owner = THIS_MODULE,
	.open = isl29011_open,
	.release = isl29011_close,
	.ioctl = isl29011_ioctl
};

/* Return 0 if detection is successful, -ENODEV otherwise */
static int isl29011_detect(struct i2c_client *client, int kind,
			  struct i2c_board_info *info)
{
	int ret;
	struct i2c_adapter *adapter = client->adapter;

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
				     | I2C_FUNC_SMBUS_READ_BYTE))
		return -ENODEV;

	/* probe that if isl29011 is at the i2 address */
	if (i2c_smbus_xfer(adapter, client->addr, 0,I2C_SMBUS_WRITE,
		0,I2C_SMBUS_QUICK,NULL) < 0)
		return -ENODEV;

	strlcpy(info->type, "isl29011", I2C_NAME_SIZE);
	printk(KERN_INFO "%s is found at i2c device address %d\n", info->type, client->addr);

	return 0;
}

static int isl29011_probe(struct i2c_client *client,
			 const struct i2c_device_id *id)
{
	/* initial device data struct */
	isl29011_data.minor = 0;
	isl29011_data.client = client;
	isl29011_data.dev_open_cnt = 0;
	spin_lock_init(&isl29011_data.lock);

	i2c_set_clientdata(client,&isl29011_data);
	printk(KERN_INFO "isl29011 device file is registered at MAJOR = %d,MINOR = %d\n",
	ISL29011_MAJOR, isl29011_data.minor);
	return 0;
}

static int isl29011_remove(struct i2c_client *client)
{
	printk(KERN_INFO "%s at address %d is removed\n",client->name,client->addr);

	/* clean the isl29011 data struct when isl29011 device remove */
	isl29011_data.minor = 255;
	isl29011_data.client = NULL;
	isl29011_data.dev_open_cnt = 0;
	return 0;
}

#ifdef CONFIG_PM	/* if define power manager, define suspend and resume function */
static int isl29011_suspend(struct i2c_client *client, pm_message_t mesg)
{
	u32 buf_32;
	struct isl29011_data_t *p_data = i2c_get_clientdata(client);

	/* save power set now, and then set isl29011 to power down mode */
	buf_32 = i2c_smbus_read_byte_data(p_data->client,0x00);
	if (buf_32 < 0) return -EIO;

	p_data->pwr_status = (u8)buf_32 & 0xe0;
	return i2c_smbus_write_byte_data(client,0x00,(u8)buf_32 & (~0xe0));
}

static int isl29011_resume(struct i2c_client *client)
{
	u32 buf_32;
	u8	buf_8;
	struct isl29011_data_t *p_data = i2c_get_clientdata(client);

	/* resume the power staus of isl29011 */
	buf_32 = i2c_smbus_read_byte_data(p_data->client,0x00);
	if (buf_32 < 0) return -EIO;

	buf_8 = (buf_32 & (~0xe0)) | p_data->pwr_status;

	return i2c_smbus_write_byte_data(client,0x00,buf_8);
}
#else
#define	isl29011_suspend 	NULL
#define isl29011_resume		NULL
#endif		/*ifdef CONFIG_PM end*/

static const struct i2c_device_id isl29011_id[] = {
	{ "isl29011", 0 },
	{ }
};

static struct i2c_driver isl29011_driver = {
	.driver = {
		.name	= "isl29011",
	},
	.probe			= isl29011_probe,
	.remove			= isl29011_remove,
	.id_table		= isl29011_id,
	.detect			= isl29011_detect,
	.address_data	= &addr_data,
	.suspend		= isl29011_suspend,
	.resume			= isl29011_resume
};

struct i2c_client *isl29011_client;

static int __init isl29011_init(void)
{
	int ret;

	/* register the i2c driver for isl29011 */
	ret = i2c_add_driver(&isl29011_driver);
	if (ret) goto ADD_DRV_FAIL;

	/* regsiter the char device file for isl29011 */
	ret = register_chrdev(ISL29011_MAJOR, DEVICE_NAME, &isl29011_fops);
	if (ret < 0) goto reg_chrdev_err;

	return 0;

ADD_DRV_FAIL:
	i2c_del_driver(&isl29011_driver);
	printk(KERN_ERR "Add isl29011 driver error\n");
	return ret;

reg_chrdev_err:
	printk(KERN_ERR "Register device file failed\n");
	i2c_del_driver(&isl29011_driver);
	return ret;
}

static void __exit isl29011_exit(void)
{
	unregister_chrdev(ISL29011_MAJOR,DEVICE_NAME);
	i2c_del_driver(&isl29011_driver);
}


MODULE_AUTHOR("Chen Shouxian");
MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("isl29011 ambient light sensor driver");
MODULE_VERSION(DRIVER_VERSION);

module_init(isl29011_init);
module_exit(isl29011_exit);

#endif stopHere
