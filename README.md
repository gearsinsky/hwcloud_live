## hwcloud_live 
Manager 14 account 84 domain name 

1.module,for each,map,worksapce應用
<br>
2.loacl exec 吃shell變數，利用hcloud內建帳號管理拆分
<br>
3.depend on ，一層一層走(內建機制看起來會同時做)
<br>
4.local exec tigger（可設定每次觸發time），resoruce則是resource有變動時
<br>
5. 手動刪雲資源，state找不到必須state rm resoruce 同步，才可繼續進行作業