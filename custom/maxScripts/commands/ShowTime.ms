UnRegisterRedrawViewsCallback ShowCurrentTimeSecond
Fn ShowCurrentTimeSecond = 
(
    local tempString
    GW.SetTransform(Matrix3 1)
    tempString = "Second:" + (CurrentTime.Frame / FrameRate) as string
    GW.hText [GW.GetWinSizeX()*0.45,30,0] tempString  color:yellow
    GW.EnlargeUpdateRect #Whole
)
RegisterRedrawViewsCallback ShowCurrentTimeSecond