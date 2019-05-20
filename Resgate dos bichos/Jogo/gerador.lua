-- Movimentação caçador

timeSet = 3000
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
        cacador1:play()
        transition.to(cacador1, { time = timeSet, delay = 0, x = cacador1.x + 500, transition = easing.linear })
       

        cacador2:setSequence("right")
        cacador2:play()
        transition.to(cacador2, { time = timeSet, delay = 0, x = cacador2.x + 500, transition = easing.linear})
        

        cacador3:setSequence("right")
        cacador3:play()
        transition.to(cacador3, { time = timeSet, delay = 0, x = cacador3.x + 500, transition = easing.linear})
        

        cacador4:setSequence("right")
        cacador4:play()
        transition.to(cacador4, { time = timeSet, delay = 0, x = cacador4.x + 500, transition = easing.linear})
       

        cacador5:setSequence("right")
        cacador5:play()
        transition.to(cacador5, { time = timeSet, delay = 0, x = cacador5.x + 500, transition = easing.linear})
        

        cacador6:setSequence("right")
        cacador6:play()
        transition.to(cacador6, { time = timeSet, delay = 0, x = cacador6.x + 500, transition = easing.linear})
        

        cacador7:setSequence("right")
        cacador7:play()
        transition.to(cacador7, { time = timeSet, delay = 0, x = cacador7.x + 500, transition = easing.linear})
        

        cacador8:setSequence("right")
        cacador8:play()
        transition.to(cacador8, { time = timeSet, delay = 0, x = cacador8.x + 500, transition = easing.linear})
        

        cacador9:setSequence("right")
        cacador9:play()
        transition.to(cacador9, { time = timeSet, delay = 0, x = cacador9.x + 500, transition = easing.linear})
        

        cacador10:setSequence("right")
        cacador10:play()
        transition.to(cacador10, { time = timeSet, delay = 0, x = cacador10.x + 500, transition = easing.linear})
        

        cacador11:setSequence("right")
        cacador11:play()
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x + 500, transition = easing.linear})
        

        cacador12:setSequence("right")
        cacador12:play()
        transition.to(cacador12, { time = timeSet, delay = 0, x = cacador12.x + 500, transition = easing.linear})
       

        cacador13:setSequence("right")
        cacador13:play()
        transition.to(cacador13, { time = timeSet, delay = 0, x = cacador13.x + 500, transition = easing.linear})
       

        cacador14:setSequence("right")
        cacador14:play()
        transition.to(cacador14, { time = timeSet, delay = 0, x = cacador14.x + 500, transition = easing.linear})
        

        cacador15:setSequence("right")
        cacador15:play()
        transition.to(cacador15, { time = timeSet, delay = 0, x = cacador15.x + 500, transition = easing.linear, onComplete = ponto_x2})
        
    end
    function ponto_x2()
        cacador1:setSequence("left")
        cacador1:play()
        transition.to(cacador1, { time = timeSet, delay = 0, x = cacador1.x - 500, transition = easing.linear })
       

        cacador2:setSequence("left")
        cacador2:play()
        transition.to(cacador2, { time = timeSet, delay = 0, x = cacador2.x - 500, transition = easing.linear})
        

        cacador3:setSequence("left")
        cacador3:play()
        transition.to(cacador3, { time = timeSet, delay = 0, x = cacador3.x - 500, transition = easing.linear})
        

        cacador4:setSequence("left")
        cacador4:play()
        transition.to(cacador4, { time = timeSet, delay = 0, x = cacador4.x - 500, transition = easing.linear})
       

        cacador5:setSequence("left")
        cacador5:play()
        transition.to(cacador5, { time = timeSet, delay = 0, x = cacador5.x - 500, transition = easing.linear})
        

        cacador6:setSequence("left")
        cacador6:play()
        transition.to(cacador6, { time = timeSet, delay = 0, x = cacador6.x - 500, transition = easing.linear})
        

        cacador7:setSequence("left")
        cacador7:play()
        transition.to(cacador7, { time = timeSet, delay = 0, x = cacador7.x - 500, transition = easing.linear})
        

        cacador8:setSequence("left")
        cacador8:play()
        transition.to(cacador8, { time = timeSet, delay = 0, x = cacador8.x - 500, transition = easing.linear})
       

        cacador9:setSequence("left")
        cacador9:play()
        transition.to(cacador9, { time = timeSet, delay = 0, x = cacador9.x - 500, transition = easing.linear})
        

        cacador10:setSequence("left")
        cacador10:play()
        transition.to(cacador10, { time = timeSet, delay = 0, x = cacador10.x - 500, transition = easing.linear})
       

        cacador11:setSequence("left")
        cacador11:play()
        transition.to(cacador11, { time = timeSet, delay = 0, x = cacador11.x - 500, transition = easing.linear} )
        

        cacador12:setSequence("left")
        cacador12:play()
        transition.to(cacador12, { time = timeSet, delay = 0, x = cacador12.x - 500, transition = easing.linear})
        

        cacador13:setSequence("left")
        cacador13:play()
        transition.to(cacador13, { time = timeSet, delay = 0, x = cacador13.x - 500, transition = easing.linear})
       

        cacador14:setSequence("left")
        cacador14:play()
        transition.to(cacador14, { time = timeSet, delay = 0, x = cacador14.x - 500, transition = easing.linear})
        

        cacador15:setSequence("left")
        cacador15:play()
        transition.to(cacador15, { time = timeSet, delay = 0, x = cacador15.x - 500, transition = easing.linear, onComplete = ponto_x1})
       
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
        cacador16:play()
        transition.to(cacador16, { time = timeSet, delay = 0, y = cacador16.y + 500, transition = easing.linear })
       

        cacador17:setSequence("down")
        cacador17:play()
        transition.to(cacador17, { time = timeSet, delay = 0, y = cacador17.y + 500, transition = easing.linear})
       

        cacador18:setSequence("down")
        cacador18:play()
        transition.to(cacador18, { time = timeSet, delay = 0, y = cacador18.y + 500, transition = easing.linear})
       

        cacador19:setSequence("down")
        cacador19:play()
        transition.to(cacador19, { time = timeSet, delay = 0, y = cacador19.y + 500, transition = easing.linear})
        

        cacador20:setSequence("down")
        cacador20:play()
        transition.to(cacador20, { time = timeSet, delay = 0, y = cacador20.y + 500, transition = easing.linear})
        

        cacador21:setSequence("down")
        cacador21:play()
        transition.to(cacador21, { time = timeSet, delay = 0, y = cacador21.y + 500, transition = easing.linear})
        

        cacador22:setSequence("down")
        cacador22:play()
        transition.to(cacador22, { time = timeSet, delay = 0, y = cacador22.y + 500, transition = easing.linear})
        

        cacador23:setSequence("down")
        cacador23:play()
        transition.to(cacador23, { time = timeSet, delay = 0, y = cacador23.y + 500, transition = easing.linear})
        

        cacador24:setSequence("down")
        cacador24:play()
        transition.to(cacador24, { time = timeSet, delay = 0, y = cacador24.y + 500, transition = easing.linear})
        

        cacador25:setSequence("down")
        cacador25:play()
        transition.to(cacador25, { time = timeSet, delay = 0, y = cacador25.y + 500, transition = easing.linear})
        

        cacador26:setSequence("down")
        cacador26:play()
        transition.to(cacador26, { time = timeSet, delay = 0, y = cacador26.y + 500, transition = easing.linear})
        

        cacador27:setSequence("down")
        cacador27:play()
        transition.to(cacador27, { time = timeSet, delay = 0, y = cacador27.y + 500, transition = easing.linear})
        

        cacador28:setSequence("down")
        cacador28:play()
        transition.to(cacador28, { time = timeSet, delay = 0, y = cacador28.y + 500, transition = easing.linear})
        

        cacador29:setSequence("down")
        cacador29:play()
        transition.to(cacador29, { time = timeSet, delay = 0, y = cacador29.y + 500, transition = easing.linear})
        

        cacador30:setSequence("down")
        cacador30:play()
        transition.to(cacador30, { time = timeSet, delay = 0, y = cacador30.y + 500, transition = easing.linear, onComplete = ponto_x4})
        
    end

    function ponto_x4()
        cacador16:setSequence("up")
        cacador16:play()
        transition.to(cacador16, { time = timeSet, delay = 0, y = cacador16.y - 500, transition = easing.linear })
        

        cacador17:setSequence("up")
        cacador17:play()
        transition.to(cacador17, { time = timeSet, delay = 0, y = cacador17.y - 500, transition = easing.linear})
        

        cacador18:setSequence("up")
        cacador18:play()
        transition.to(cacador18, { time = timeSet, delay = 0, y = cacador18.y - 500, transition = easing.linear})
        

        cacador19:setSequence("up")
        cacador19:play()
        transition.to(cacador19, { time = timeSet, delay = 0, y = cacador19.y - 500, transition = easing.linear})
        

        cacador20:setSequence("up")
        cacador20:play()
        transition.to(cacador20, { time = timeSet, delay = 0, y = cacador20.y - 500, transition = easing.linear})
        

        cacador21:setSequence("up")
        cacador21:play()
        transition.to(cacador21, { time = timeSet, delay = 0, y = cacador21.y - 500, transition = easing.linear})
       

        cacador22:setSequence("up")
        cacador22:play()
        transition.to(cacador22, { time = timeSet, delay = 0, y = cacador22.y - 500, transition = easing.linear})
        

        cacador23:setSequence("up")
        cacador23:play()
        transition.to(cacador23, { time = timeSet, delay = 0, y = cacador23.y - 500, transition = easing.linear})
      

        cacador24:setSequence("up")
        cacador24:play()
        transition.to(cacador24, { time = timeSet, delay = 0, y = cacador24.y - 500, transition = easing.linear})
        

        cacador25:setSequence("up")
        cacador25:play()
        transition.to(cacador25, { time = timeSet, delay = 0, y = cacador25.y - 500, transition = easing.linear})
        

        cacador26:setSequence("up")
        cacador26:play()
        transition.to(cacador26, { time = timeSet, delay = 0, y = cacador26.y - 500, transition = easing.linear})
       

        cacador27:setSequence("up")
        cacador27:play()
        transition.to(cacador27, { time = timeSet, delay = 0, y = cacador27.y - 500, transition = easing.linear})
        

        cacador28:setSequence("up")
        cacador28:play()
        transition.to(cacador28, { time = timeSet, delay = 0, y = cacador28.y - 500, transition = easing.linear})
        

        cacador29:setSequence("up")
        cacador29:play()
        transition.to(cacador29, { time = timeSet, delay = 0, y = cacador29.y - 500, transition = easing.linear})
        

        cacador30:setSequence("up")
        cacador30:play()
        transition.to(cacador30, { time = timeSet, delay = 0, y = cacador30.y - 500, transition = easing.linear, onComplete = ponto_x3})
        
    end
    
    ponto_x1()
    ponto_x3()
    
end