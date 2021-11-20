#!/usr/bin/python
# -*-            coding:utf-8                            -*-

import pymysql
import logPrinter
import traceback
import time
import re
import random

# 数据库处理
class DBHelper(object):
    # 构造函数
    def __init__(self, host, port, user, password, database):
        self.host = host
        self.port = port
        self.user = user
        self.pwd = password
        self.db = database
        self.conn = None
        self.cur = None
        self.logger = logPrinter.get_logger(name="DBHelper", outFile=True, outConsole=False)


    # 连接数据库
    def connectDatabase(self):
        try:
            self.conn = pymysql.connect(host=self.host, port=self.port, user=self.user, password=self.pwd, db=self.db, charset='utf8')
        except:
            self.logger.error("connectDatabase failed")
            self.logger.error("{}".format(traceback.format_exc()))
            return False

        self.cur = self.conn.cursor()
        return True

    # 关闭数据库
    def close(self):
        # 如果数据打开，则关闭；否则没有操作
        if self.conn and self.cur:
            self.cur.close()
            self.conn.close()

        return True

    # 执行数据库的sql语句， 主要用来做插入操作
    def execute(self, sql, params=None):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30, 60))
        insertId = -1
        sqlType = sql.split(" ")[0]
        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql， 提交操作
                self.cur.execute(sql, params)
                if sqlType == 'insert':
                    insertId = self.conn.insert_id()
                self.conn.commit()
        except:
            self.logger.error("execute failed: "+sql)
            if params is not None:
                self.logger.error("params: {}".format(params))
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            if sqlType == "insert":
                return insertId
            else:
                return False
        self.close()
        if sqlType == "insert":
            return insertId
        else:
            return True

    # 批量插入数据
    def executemany(self, sql, data):
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        try:
            if self.conn and self.cur:
                # 正常逻辑，执行sql， 批量插入数据
                self.cur.executemany(sql, data)
                self.conn.commit()
        except:
            self.logger.error("execute failed: "+sql)
            # if data is not None:
            #     self.logger.error("params: {}".format(data))
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            return False
        self.close()
        return True

    # 用来查询表数据
    def fetchall(self, sql, params=None):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        result = None

        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql
                self.cur.execute(sql, params)
                result = self.cur.fetchall()
        except pymysql.err.OperationalError:
            self.logger.info("sql: {}".format(sql))
            # self.logger.info("{}".format(pymysql.err.OperationalError))
            self.logger.info("**************** The operational error is occur.**************")
            self.close()
            time.sleep(random.randint(30,60))
            loop = True
            while loop:
                while not self.connectDatabase():
                    self.logger.info("the time sleep for connect database...")
                    time.sleep(random.randint(30,60))
                result = None
                try:
                    if self.conn and self.cur:
                        # 正常逻辑， 执行sql
                        self.cur.execute(sql, params)
                        result = self.cur.fetchall()
                        loop = False
                except pymysql.err.OperationalError:
                    self.logger.info("**************** The operational error is occur.**************")
                    self.close()
                    time.sleep(random.randint(30,60))
        except:
            self.logger.error("execute failed: " + sql)
            if params is not None:
                self.logger.error("params: " + params)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            return None
        self.close()

        return result

    # 构建临时表处理查询
    def fetchallWithTempTab(self, sql, tbName, name, ntype, data, params=None):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        result = None

        try:
            if self.conn and self.cur:
                # 创建临时表
                csql = "CREATE TEMPORARY TABLE {}(" \
                      "id int not null auto_increment primary key," \
                      "{} {});".format(tbName, name, ntype)
                self.logger.info("the csql is: {}".format(csql))
                flag = self.cur.execute(csql)
                self.logger.info("the csql flag is: {}".format(flag))
                # 插入数据
                isql = "INSERT INTO {}({}) VALUES (%s)".format(tbName, name)
                newList= []
                for i in range(len(data)):
                    newList.append(tuple([data[i]]))
                flag = self.cur.executemany(isql, newList)
                self.conn.commit()
                self.logger.info("the isql flag is: {}".format(flag))
                # 正常逻辑， 执行sql
                flag = self.cur.execute(sql, params)
                self.logger.info("the sql flag is: {}".format(flag))
                result = self.cur.fetchall()
                self.logger.info("the sql result size is: {}".format(len(result)))
        except:
            self.logger.error("execute failed: " + sql)
            if params is not None:
                self.logger.error("params: " + params)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            return None
        self.close()
        return result

    # 带字段名的查询函数
    def fetchallWithCols(self, sql, params=None):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        result = None
        cols = None
        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql
                self.cur.execute(sql, params)
                cols = self.cur.description
                result = self.cur.fetchall()
        except:
            self.logger.error("execute failed: "+sql)
            if params is not None:
                self.logger.error("params: "+params)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            return None, cols
        self.close()
        return result, cols

    # 判断表是否在库中
    def tableExists(self, tableName):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        sql = "show tables;"
        tables = []
        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql
                self.cur.execute(sql)
                tables = [self.cur.fetchall()]
        except:
            self.logger.error("execute failed: "+sql)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            # 报错返回None
            return None
        self.close()
        # self.logger.info("the tables is: {}".format(tables))
        tableList = re.findall('(\'.*?\')', str(tables))
        # self.logger.info("the table list is: {}".format(tableList))
        tableList = [re.sub("'", '', each) for each in tableList]
        # self.logger.info("the table list is: {}".format(tableList))
        if tableName in tableList:
            # 存在返回True
            return True
        else:
            # 不存在返回False
            return False

    # 获取数据库中的所有表
    def showTables(self):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        sql = "show tables;"
        tables = []
        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql
                self.cur.execute(sql)
                tables = [self.cur.fetchall()]
        except:
            self.logger.error("execute failed: " + sql)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            # 报错返回None
            return None
        self.close()
        # self.logger.info("the tables is: {}".format(tables))
        tableList = re.findall('(\'.*?\')', str(tables))
        # self.logger.info("the table list is: {}".format(tableList))
        tableList = [re.sub("'", '', each) for each in tableList]

        return tableList

    # 返回包含指定名称的最新数据表名
    def searchNewTable(self, tableName):
        # 连接数据库
        while not self.connectDatabase():
            self.logger.info("the time sleep for connect database...")
            time.sleep(random.randint(30,60))
        sql = "show tables;"
        tables = []
        try:
            if self.conn and self.cur:
                # 正常逻辑， 执行sql
                self.cur.execute(sql)
                tables = [self.cur.fetchall()]
        except:
            self.logger.error("execute failed: " + sql)
            self.logger.error("{}".format(traceback.format_exc()))
            self.close()
            # 报错返回None
            return None
        self.close()
        # self.logger.info("the tables is: {}".format(tables))
        tableList = re.findall('(\'.*?\')', str(tables))
        # self.logger.info("the table list is: {}".format(tableList))
        tableList = [re.sub("'", '', each) for each in tableList]
        # self.logger.info("the table list is: {}".format(tableList))
        content = []
        for item in tableList:
            if tableName in item:
                content.append(item)

        content = sorted(content)

        return content[-1]
