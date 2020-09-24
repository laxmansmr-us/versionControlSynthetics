# Configure the New Relic provider
provider "newrelic" {
  api_key       =  "NRAK-TGF8HS91I642C4D0MWC5R687KVA"
  admin_api_key =  "NRAA-b97495fda60c15163162c510314"
  account_id    =  "2615841"
  region        = "US"
}

# SCRIPTED BROWSER MONITOR CREATION
resource "newrelic_synthetics_monitor" "tf_scripted" {
  name = "Ryans Scripted Browser"
  type = "SCRIPT_BROWSER"
  frequency = 1
  status = "ENABLED"
  locations = ["AWS_EU_WEST_1"]
}

data "template_file" "BrowserScript" {
  template = templatefile("${path.module}/script.tpl", {uri = "https://newrelic.com"})
}

resource "newrelic_synthetics_monitor_script" "BrowserScript" {
  monitor_id = newrelic_synthetics_monitor.tf_scripted.id
  text = data.template_file.BrowserScript.rendered
}


