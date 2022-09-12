import os
import subprocess
from pathlib import Path
from tkinter import *
import numpy as np

from PIL import ImageTk, Image


class Window:
    NAME = 'Bilinear Picker'
    WIN_SIZE = '1024x768'
    IMAGE_INPUT_CONFIG = {'width': 390, 'height': 390}
    BASE_DIR = Path(__file__).resolve().parent
    root = None
    PAD = 5

    def __init__(self):
        self.root = Tk()
        self.root.title(self.NAME)
        self.root.geometry(self.WIN_SIZE)
        self.root.resizable(False, False)
        self.section: Text = None

    def process(self):
        inp = self.section.get(1.0, "end-1c")
        value_section = int(inp)

        img = Image.open(self.BASE_DIR / 'media' / 'bacteria.jpg')

        posx = 0
        posy = 0


        if value_section == 1:
            posx = 97
            posy = 0
        elif value_section == 2:
            posx = 97 * 2
            posy = 0
        elif value_section == 3:
            posx = 97 * 3
            posy = 0
        elif value_section == 4:
            posx = 0
            posy = 97
        elif value_section == 5:
            posx = 97
            posy = 97
        elif value_section == 6:
            posx = 97 * 2
            posy = 97
        elif value_section == 7:
            posx = 97 * 3
            posy = 97
        elif value_section == 8:
            posx = 0
            posy = 97 * 2
        elif value_section == 9:
            posx = 97
            posy = 97 * 2
        elif value_section == 10:
            posx = 97 * 2
            posy = 97 * 2
        elif value_section == 11:
            posx = 97 * 3
            posy = 97 * 2
        elif value_section == 12:
            posx = 0
            posy = 97 * 3
        elif value_section == 13:
            posx = 97
            posy = 97 * 3
        elif value_section == 14:
            posx = 97 * 2
            posy = 97 * 3
        elif value_section == 15:
            posx = 97 * 3
            posy = 97 * 3

        cropped = img.crop((posx, posy, 97, 97)).convert('L')

        data = list(cropped.getdata())

        with open("input.img", "wb") as f:
            f.write(bytes(data))

        os.system(self.BASE_DIR / 'processor')

        pixels = []

        with open("output.img", 'rb') as fil:
            c = 289
            while c != 0:
                f = 289
                row = []
                while f != 0:
                    byte = fil.read(1)
                    row.append(int.from_bytes(byte, 'little'))
                    f -= 1
                pixels.append(row)
                c -= 1

        array = np.array(pixels, dtype=np.uint8)

        new_image = Image.fromarray(array)
        new_image.save("new_image.png")

    def start(self):
        input_img_frame = LabelFrame(self.root, text="Imagen de entrada")
        input_img_frame.grid(row=0, column=0, sticky=W, padx=self.PAD, pady=self.PAD)

        in_img_preview = Canvas(input_img_frame, self.IMAGE_INPUT_CONFIG)
        image = self.BASE_DIR / 'media' / 'bacteria.jpg'
        in_img = ImageTk.PhotoImage(Image.open(image))
        in_img_preview.create_image(0, 0, anchor=NW, image=in_img)
        in_img_preview.grid(row=0, column=0, sticky=W, padx=self.PAD, pady=self.PAD)

        out_img_frame = LabelFrame(self.root, text="Imagen de salida")
        out_img_frame.grid(row=0, column=1, sticky=W, padx=self.PAD, pady=self.PAD)

        self.out_img_preview = Canvas(out_img_frame, self.IMAGE_INPUT_CONFIG)
        self.out_img_preview.grid(row=0, column=1, sticky=W, padx=self.PAD, pady=self.PAD)
        out_img = ImageTk.PhotoImage(Image.open(image))
        self.output_container = self.out_img_preview.create_image(0, 0, anchor=NW, image=out_img)

        self.section = Text(self.root,height=5,width=20)
        self.section.grid(row=1, column=0, columnspan=2, sticky=W, padx=self.PAD, pady=self.PAD)

        process = Button(self.root, text="Procesar sección", command=self.process)
        process.grid(row=2, column=0, columnspan=2, sticky=W, padx=self.PAD, pady=self.PAD)

        self.root.mainloop()


if __name__ == '__main__':
    win = Window()
    win.start()