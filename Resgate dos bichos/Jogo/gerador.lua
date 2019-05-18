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
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x + 500, transition = easing.linear, onComplete = ponto_x2})
        print("11")
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
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x - 500, transition = easing.linear, onComplete = ponto_x1})
        print("11")
    end

    

    ponto_x1()
    
    

end