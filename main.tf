# Configure the New Relic provider
provider "newrelic" {
  api_key       =  "YOUR PERSONAL API KEY" # https://docs.newrelic.com/docs/apis/get-started/intro-apis/types-new-relic-api-keys#personal-api-key
  admin_api_key =  "YOUR ADMIN API KEY" # https://docs.newrelic.com/docs/apis/get-started/intro-apis/types-new-relic-api-keys#admin
  account_id    =  "YOUR NEW RELIC ACCOUNT ID"
  region        = "YOUR NEW RELIC DATACENTER REGION" # US or EU
}

# SCRIPTED BROWSER MONITOR CREATION
resource "newrelic_synthetics_monitor" "tf_scripted" {
  name = "Ryan's scripted monitor - Terraform & GH Actions"
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


