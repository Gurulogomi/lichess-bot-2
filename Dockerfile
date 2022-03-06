FROM ubuntu:impish
MAINTAINER OIVAS7572
RUN echo OIVAS7572
COPY . .
COPY requirements.txt .

# If you want to run any other commands use "RUN" before.


RUN apt update > aptud.log && apt install -y wget python3 python3-pip p7zip-full > apti.log

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
&& 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z

RUN wget --no-check-certificate -nv "https://abrok.eu/stockfish/builds/270a0e737fea1774b409f70f378ca52cbc42dd3d/linux64ssse/stockfish_22030223_x64_ssse.zip" -O chess-engine.zip \
&& 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

RUN bash sf.sh
RUN chmod +x sf
RUN chmod +x chess-engine
#Engine name ^^^^^^^^^^^^

CMD python3 lichess-bot.py -u
