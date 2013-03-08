<? $lastmod = date("F d, Y g:i A", filemtime("img/temp_yearly.png")); ?>
<html>
<head>
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="refresh" content="3600" >
  <title>RPi Temperature</title>
  <style>
      BODY 
      { 
        font-family: arial; 
        font-size: 10pt;
        background-repeat: no-repeat; background-position: center center; 
      }
 
      H2 { margin-bottom: 0; }
  </style>
</head>
<body>
  <div style="width: 980px; margin-left: 200px;" >
    <h2>RPi Temperature Inside & Outside</h2>
    <i>Last Modified: <?=$lastmod?></i>
     
    <p>
        <img src="img/temp_hourly.png" />
        <img src="img/humidity_hourly.png" />

        <img src="img/temp_daily.png" />
        <img src="img/humidity_daily.png" />

        <img src="img/temp_weekly.png" />
        <img src="img/humidity_weekly.png" />

        <img src="img/temp_monthly.png" />
        <img src="img/humidity_monthly.png" />

        <img src="img/temp_yearly.png" />
        <img src="img/humidity_yearly.png" />
    </p>
  </div>
</body>
</html>
