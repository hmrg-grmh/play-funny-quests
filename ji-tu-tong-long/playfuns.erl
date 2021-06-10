- module (playfuns) .
- export ([wbbazza/3]) .

wbbazza 
    ( {AllA, AllZ}
    , {WebiA, WebiZ}
    , {BaboA, BaboZ} )
-> 
    WebiHooAz = (AllZ - BaboZ * AllA / BaboA) / (WebiZ - BaboZ * WebiA / BaboA) , 
    ThenBaboHooAz = AllA / BaboA - WebiHooAz * WebiA / BaboA , 
    
    WebiHooZa = (AllA - BaboA * AllZ / BaboZ) / (WebiA - BaboA * WebiZ / BaboZ) , 
    ThenBaboHooZa = AllZ / BaboZ - WebiHooZa * WebiZ / BaboZ , 
    
    BaboHooAz = (AllZ - WebiZ * AllA / WebiA) / (BaboZ - WebiZ * BaboA / WebiA) , 
    ThenWebiHooAz = AllA / WebiA - BaboHooAz * BaboA / WebiA , 
    
    BaboHooZa = (AllA - WebiA * AllZ / WebiZ) / (BaboA - WebiA * BaboZ / WebiZ) , 
    ThenWebiHooZa = AllZ / WebiZ - BaboHooZa * BaboZ / WebiZ , 
    
    [ {webi_then_babo_az, {WebiHooAz, ThenBaboHooAz} }
    , {webi_then_babo_za, {WebiHooZa, ThenBaboHooZa} }
    , {babo_then_webi_az, {ThenWebiHooAz, BaboHooAz} }
    , {babo_then_webi_za, {ThenWebiHooZa, BaboHooZa} } ] .

%%%%%%%%%%%%%%%%

%% 现在假设有: 
%% - 3头 6足 算作webi 一共 21只
%% - 7头 1足 算作babo 一共 78只
%% 那么: 
%% - 头一共: 3 * 21 + 7 * 78 = 609
%% - 足一共: 6 * 21 + 1 * 78 = 204
%% 
%% 那么, 测试 playfuns:wbbazza/3 : 
%% c(playfuns). playfuns:wbbazza({609, 204}, {3,6}, {7,1}). 
%% 
%% 就应该得到结果: 
%% [{webi_then_babo_az,{21.0,78.0}},
%%  {webi_then_babo_za,{21.0,78.0}},
%%  {babo_then_webi_az,{21.0,78.0}},
%%  {babo_then_webi_za,{21.0,78.0}}]
%% 
%% 试了一下是这结果
%% ----: 1次随机测试成功!!

%%%%%%%%%%%%%%%%
