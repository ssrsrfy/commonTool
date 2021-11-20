#!/usr/bin/python
# -*-        coding:utf-8                  -*-

import logging
import sys
import os


# 加入日志
# 获取logger实例
def get_logger(name, outFile=False, outConsole=True):
    """
    Python使用logging模块记录日志涉及四个主要类，使用官方文档中的概括最为合适:
    1>.logger提供了应用程序可以直接使用的接口;
    2>.handler将(logger创建的)日志记录发送到合适的目的输出;
    3>.filter提供了细度设备来决定输出哪条日志记录;
    4>.formatter决定日志记录的最终输出格式。
    :param name:                对象名称
    :param outFile:             是否要输出到文件中，默认为False
    :param outConsole:          是否要输出到控制台，默认为True
    :return:                    返回logger对象
    """
    # 获取logger实例
    logger_ojb = logging.getLogger(name=name)

    # 指定输出格式
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    # 文件日志
    if outFile:
        dir = os.path.dirname(os.path.realpath(__file__))
        file_handler = logging.FileHandler(filename=os.path.join(dir, name + ".log"))  # 创建一个文件输出流
        file_handler.setLevel(level=logging.INFO)  # 定义文件输出流的告警级别
        file_handler.setFormatter(fmt=formatter)  # 添加格式输出

    # 控制台输出
    if outConsole:
        console_handler = logging.StreamHandler(stream=sys.stdout)  # 创建一个屏幕输出流
        console_handler.setLevel(level=logging.INFO)  # 定义屏幕输出流的告警级别
        console_handler.setFormatter(fmt=formatter)  # 添加格式输出

    if outFile:
        logger_ojb.addHandler(hdlr=file_handler)

    if outConsole:
        logger_ojb.addHandler(hdlr=console_handler)

    logger_ojb.setLevel(level=logging.INFO)
    return logger_ojb