
MaksymalnyRozmiarKamery = 0.3
kamerawlaczona = false
j = 0



RegisterCommand("kfilmowa", function()
    kamerawlaczona = not kamerawlaczona
    wlaczkamere(kamerawlaczona)
end)

function wlaczkamere(bool) 
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        DisplayRadar(false)
        DisplayHealthArmour(3)
        for i = 0, MaksymalnyRozmiarKamery, 0.01 do 
            Wait(10)
            j = i
        end
    else
        DisplayRadar(true)
        DisplayHealthArmour(0)
        for i = MaksymalnyRozmiarKamery, 0, -0.01 do
            Wait(10)
            j = i
        end 
    end
end    

function DisplayHealthArmour(int) 
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(int)
    EndScaleformMovieMethod()
end


Citizen.CreateThread(function() 

    minimap = RequestScaleformMovie("minimap") 

    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do 
            Wait(1)
        end
    end

    while true do
        Citizen.Wait(1)
        if j > 0 then
            DrawRects()
        end
        if kamerawlaczona then
            wylaczHUD()
        end
    end
end)

function DrawRects() 
    DrawRect(0.0, 0.0, 2.0, j, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, j, 0, 0, 0, 255)
end

function wylaczHUD()
    for i = 0, 22, 1 do
        if IsHudComponentActive(i) then
            HideHudComponentThisFrame(i)
            
        end
    end
end