# Configure the New Relic provider
provider "newrelic" {
  api_key       =  "NRAK-62H9LDKOK15PQW869BC1L72UIWR"
  admin_api_key =  "NRAA-26febaf6f5d4865317d0d9f0d4e"
  account_id    =  "1133910"
  region        = "US"
}

# SCRIPTED BROWSER MONITOR CREATION
resource "newrelic_synthetics_monitor" "tf_scripted" {
  name = "ghActionsTest"
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


