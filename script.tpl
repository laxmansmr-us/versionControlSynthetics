$browser.get("${uri}").then(function(){
  $browser.sleep(2000).then(function(){
      $browser.takeScreenshot();
      console.log("Ryans awesome script frickin works!");
      console.log("BLARGGGHHHHHHH");
      console.log("BLARGGGHHHHHHH");
  })
});
