#!/usr/bin/python
# -*- coding: utf-8 -*-

#
# Name:	Zhuyin Typo
# Version:	0.3.1
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Zhi-Wei Cai.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#


import Tkinter
import tkMessageBox
import pyautogui
import subprocess
import time
import platform

class zhuyin_typo(Tkinter.Tk):
    def __init__(self, parent):
        Tkinter.Tk.__init__(self, parent)
        self.parent = parent
        self.initialize()

    def initialize(self):
        self.grid()
        self.entryVariable = Tkinter.StringVar()
        self.entryVariable.set(u'5j/ m61j6m/4y94tj/6283xk7')
        # ㄓㄨㄥ ㄩˊㄅㄨˊㄩㄥˋㄗㄞˋㄔㄨㄥˊㄉㄚˇㄌㄜ˙

        self.entry = Tkinter.Entry(self,
                                   textvariable=self.entryVariable)
        self.entry.bind('<Return>', self.enter)
        self.entry.grid(column=0,
                        row=1,
                        sticky='EW')
        b = Tkinter.Button(self,
                           text=u'好！',
                           command=self.click)
        b.grid(column=1,
               row=1)
        b = Tkinter.Button(self,
                           text=u'幫我重打',
                           command=self.autoType)
        b.grid(column=2,
               row=1)

        self.labelVariable = Tkinter.StringVar()
        label = Tkinter.Label(self,
                              textvariable=self.labelVariable)
        label.grid(column=0,
                   row=0,
                   columnspan=2,
                   sticky='EW')
        self.labelVariable.set(u'請輸入打錯的注音英文')

        self.grid_columnconfigure(0,
                                  weight=1)
        self.resizable(False,
                       False)

        self.update()
        self.entry.focus_set()
        self.entry.selection_range(0,
                                   Tkinter.END)

    def toZhuyin(self):
        z = u'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦ˙ˊˇˋ '
        u = u'1QAZ2WSXEDCRFV5TGBYHNUJM8IK,9OL.0P;/-7634 '
        s = self.entryVariable.get().upper()
        r = u''
        for c in s:
            if c in u:
                r = r + z[u.index(c)]
            else:
                r = r + c
        return r

    def handler(self):
        result = self.toZhuyin()
        self.labelVariable.set(u'原始注音內容：「' + result + u'」。')
        self.entry.focus_set()
        self.entry.selection_range(0, Tkinter.END)

    def autoType(self):
        r = tkMessageBox.askquestion(u'注意！',
                                          u'請確定已經切換至中文輸入，且大寫鎖為解除的狀態！',
                                          icon='warning')
        if r == 'yes':
            os = platform.system()
            if os == 'Darwin':
                subprocess.call(['open',
                                 '-a',
                                 'Notes'])
            time.sleep(1)
            pyautogui.typewrite(self.entryVariable.get())

    def click(self):
        self.handler()

    def enter(self, event):
        self.handler()

if __name__ == '__main__':
    app = zhuyin_typo(None)
    app.title('Zhuyin Typo by Zhi-Wei Cai')
    app.mainloop()
