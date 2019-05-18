-- Movimentação caçador

timeSet = 2000
delaySet = 0
distanciaSet = 500

function movimentoCacador(cacadores)

    cacador1 = cacadores[1]
    cacador2 = cacadores[2]
    cacador3 = cacadores[3]
    cacador4 = cacadores[4]
    cacador5 = cacadores[5]
    cacador6 = cacadores[6]
    cacador7 = cacadores[7]
    cacador8 = cacadores[8]
    cacador9 = cacadores[9]
    cacador10 = cacadores[10]
    cacador11 = cacadores[11]
    cacador12 = cacadores[12]
    cacador13 = cacadores[13]
    cacador14 = cacadores[14]
    cacador15 = cacadores[15]


    

    function ponto_x1()
        cacador1:setSequence("right")
        transition.to(cacador1, { time = timeSet, delay = 0, x = cacador1.x + 500, transition = easing.linear })
        print("1")

        cacador2:setSequence("right")
        transition.to(cacador2, { time = timeSet, delay = 0, x = cacador2.x + 500, transition = easing.linear})
        print("2")

        cacador3:setSequence("right")
        transition.to(cacador3, { time = timeSet, delay = 0, x = cacador3.x + 500, transition = easing.linear})
        print("3")

        cacador4:setSequence("right")
        transition.to(cacador4, { time = timeSet, delay = 0, x = cacador4.x + 500, transition = easing.linear})
        print("4")

        cacador5:setSequence("right")
        transition.to(cacador5, { time = timeSet, delay = 0, x = cacador5.x + 500, transition = easing.linear})
        print("5")

        cacador6:setSequence("right")
        transition.to(cacador6, { time = timeSet, delay = 0, x = cacador6.x + 500, transition = easing.linear})
        print("6")

        cacador7:setSequence("right")
        transition.to(cacador7, { time = timeSet, delay = 0, x = cacador7.x + 500, transition = easing.linear})
        print("7")

        cacador8:setSequence("right")
        transition.to(cacador8, { time = timeSet, delay = 0, x = cacador8.x + 500, transition = easing.linear})
        print("8")

        cacador9:setSequence("right")
        transition.to(cacador9, { time = timeSet, delay = 0, x = cacador9.x + 500, transition = easing.linear})
        print("9")

        cacador10:setSequence("right")
        transition.to(cacador10, { time = timeSet, delay = 0, x = cacador10.x + 500, transition = easing.linear})
        print("10")

        cacador11:setSequence("right")
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x + 500, transition = easing.linear})
        print("11")

        cacador12:setSequence("right")
        transition.to(cacador12, { time = timeSet, delay = 0, x = cacador12.x + 500, transition = easing.linear})
        print("12")

        cacador13:setSequence("right")
        transition.to(cacador13, { time = timeSet, delay = 0, x = cacador13.x + 500, transition = easing.linear})
        print("13")

        cacador14:setSequence("right")
        transition.to(cacador14, { time = timeSet, delay = 0, x = cacador14.x + 500, transition = easing.linear})
        print("14")

        cacador15:setSequence("right")
        transition.to(cacador15, { time = timeSet, delay = 0, x = cacador15.x + 500, transition = easing.linear, onComplete = ponto_x2})
        print("15")
    end
    function ponto_x2()
        cacador1:setSequence("left")
        transition.to(cacador1, { time = timeSet, delay = 0, x = cacador1.x - 500, transition = easing.linear })
        print("1")

        cacador2:setSequence("left")
        transition.to(cacador2, { time = timeSet, delay = 0, x = cacador2.x - 500, transition = easing.linear})
        print("2")

        cacador3:setSequence("left")
        transition.to(cacador3, { time = timeSet, delay = 0, x = cacador3.x - 500, transition = easing.linear})
        print("3")

        cacador4:setSequence("left")
        transition.to(cacador4, { time = timeSet, delay = 0, x = cacador4.x - 500, transition = easing.linear})
        print("4")

        cacador5:setSequence("left")
        transition.to(cacador5, { time = timeSet, delay = 0, x = cacador5.x - 500, transition = easing.linear})
        print("5")

        cacador6:setSequence("left")
        transition.to(cacador6, { time = timeSet, delay = 0, x = cacador6.x - 500, transition = easing.linear})
        print("6")

        cacador7:setSequence("left")
        transition.to(cacador7, { time = timeSet, delay = 0, x = cacador7.x - 500, transition = easing.linear})
        print("7")

        cacador8:setSequence("left")
        transition.to(cacador8, { time = timeSet, delay = 0, x = cacador8.x - 500, transition = easing.linear})
        print("8")

        cacador9:setSequence("left")
        transition.to(cacador9, { time = timeSet, delay = 0, x = cacador9.x - 500, transition = easing.linear})
        print("9")

        cacador10:setSequence("left")
        transition.to(cacador10, { time = timeSet, delay = 0, x = cacador10.x - 500, transition = easing.linear})
        print("10")

        cacador11:setSequence("left")
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x - 500, transition = easing.linear} )
        print("11")

        cacador12:setSequence("left")
        transition.to(cacador12, { time = timeSet, delay = 0, x = cacador12.x - 500, transition = easing.linear})
        print("12")

        cacador13:setSequence("left")
        transition.to(cacador13, { time = timeSet, delay = 0, x = cacador13.x - 500, transition = easing.linear})
        print("13")

        cacador14:setSequence("left")
        transition.to(cacador14, { time = timeSet, delay = 0, x = cacador14.x - 500, transition = easing.linear})
        print("14")

        cacador15:setSequence("left")
        transition.to(cacador15, { time = timeSet, delay = 0, x = cacador15.x - 500, transition = easing.linear, onComplete = ponto_x1})
        print("15")
    end

    cacador16 = cacadores[16]
    cacador17 = cacadores[17]
    cacador18 = cacadores[18]
    cacador19 = cacadores[19]
    cacador20 = cacadores[20]
    cacador21 = cacadores[21]
    cacador22 = cacadores[22]
    cacador23 = cacadores[23]
    cacador24 = cacadores[24]
    cacador25 = cacadores[25]
    cacador26 = cacadores[26]
    cacador27 = cacadores[27]
    cacador28 = cacadores[28]
    cacador29 = cacadores[29]
    cacador30 = cacadores[30]


    function ponto_x3()
        cacador16:setSequence("down")
        transition.to(cacador16, { time = timeSet, delay = 0, y = cacador16.y + 500, transition = easing.linear })
        print("16")

        cacador17:setSequence("down")
        transition.to(cacador17, { time = timeSet, delay = 0, y = cacador17.y + 500, transition = easing.linear})
        print("17")

        cacador18:setSequence("down")
        transition.to(cacador18, { time = timeSet, delay = 0, y = cacador18.y + 500, transition = easing.linear})
        print("18")

        cacador19:setSequence("down")
        transition.to(cacador19, { time = timeSet, delay = 0, y = cacador19.y + 500, transition = easing.linear})
        print("19")

        cacador20:setSequence("down")
        transition.to(cacador20, { time = timeSet, delay = 0, y = cacador20.y + 500, transition = easing.linear})
        print("20")

        cacador21:setSequence("down")
        transition.to(cacador21, { time = timeSet, delay = 0, y = cacador21.y + 500, transition = easing.linear})
        print("21")

        cacador22:setSequence("down")
        transition.to(cacador22, { time = timeSet, delay = 0, y = cacador22.y + 500, transition = easing.linear})
        print("22")

        cacador23:setSequence("down")
        transition.to(cacador23, { time = timeSet, delay = 0, y = cacador23.y + 500, transition = easing.linear})
        print("23")

        cacador24:setSequence("down")
        transition.to(cacador24, { time = timeSet, delay = 0, y = cacador24.y + 500, transition = easing.linear})
        print("24")

        cacador25:setSequence("down")
        transition.to(cacador25, { time = timeSet, delay = 0, y = cacador25.y + 500, transition = easing.linear})
        print("25")

        cacador26:setSequence("down")
        transition.to(cacador26, { time = timeSet, delay = 0, y = cacador26.y + 500, transition = easing.linear})
        print("26")

        cacador27:setSequence("down")
        transition.to(cacador27, { time = timeSet, delay = 0, y = cacador27.y + 500, transition = easing.linear})
        print("27")

        cacador28:setSequence("down")
        transition.to(cacador28, { time = timeSet, delay = 0, y = cacador28.y + 500, transition = easing.linear})
        print("28")

        cacador29:setSequence("down")
        transition.to(cacador29, { time = timeSet, delay = 0, y = cacador29.y + 500, transition = easing.linear})
        print("29")

        cacador30:setSequence("down")
        transition.to(cacador30, { time = timeSet, delay = 0, y = cacador30.y + 500, transition = easing.linear, onComplete = ponto_x4})
        print("30")
    end

    function ponto_x4()
        cacador16:setSequence("up")
        transition.to(cacador16, { time = timeSet, delay = 0, y = cacador16.y - 500, transition = easing.linear })
        print("16")

        cacador17:setSequence("up")
        transition.to(cacador17, { time = timeSet, delay = 0, y = cacador17.y - 500, transition = easing.linear})
        print("17")

        cacador18:setSequence("up")
        transition.to(cacador18, { time = timeSet, delay = 0, y = cacador18.y - 500, transition = easing.linear})
        print("18")

        cacador19:setSequence("up")
        transition.to(cacador19, { time = timeSet, delay = 0, y = cacador19.y - 500, transition = easing.linear})
        print("19")

        cacador20:setSequence("up")
        transition.to(cacador20, { time = timeSet, delay = 0, y = cacador20.y - 500, transition = easing.linear})
        print("20")

        cacador21:setSequence("up")
        transition.to(cacador21, { time = timeSet, delay = 0, y = cacador21.y - 500, transition = easing.linear})
        print("21")

        cacador22:setSequence("up")
        transition.to(cacador22, { time = timeSet, delay = 0, y = cacador22.y - 500, transition = easing.linear})
        print("22")

        cacador23:setSequence("up")
        transition.to(cacador23, { time = timeSet, delay = 0, y = cacador23.y - 500, transition = easing.linear})
        print("23")

        cacador24:setSequence("up")
        transition.to(cacador24, { time = timeSet, delay = 0, y = cacador24.y - 500, transition = easing.linear})
        print("24")

        cacador25:setSequence("up")
        transition.to(cacador25, { time = timeSet, delay = 0, y = cacador25.y - 500, transition = easing.linear})
        print("25")

        cacador26:setSequence("up")
        transition.to(cacador26, { time = timeSet, delay = 0, y = cacador26.y - 500, transition = easing.linear})
        print("26")

        cacador27:setSequence("up")
        transition.to(cacador27, { time = timeSet, delay = 0, y = cacador27.y - 500, transition = easing.linear})
        print("27")

        cacador28:setSequence("up")
        transition.to(cacador28, { time = timeSet, delay = 0, y = cacador28.y - 500, transition = easing.linear})
        print("28")

        cacador29:setSequence("up")
        transition.to(cacador29, { time = timeSet, delay = 0, y = cacador29.y - 500, transition = easing.linear})
        print("29")

        cacador30:setSequence("up")
        transition.to(cacador30, { time = timeSet, delay = 0, y = cacador30.y - 500, transition = easing.linear, onComplete = ponto_x3})
        print("30")
    end
    

    ponto_x1()
    ponto_x3()
    
    

end