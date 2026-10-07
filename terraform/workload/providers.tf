provider "azurerm" {
  features {}

  subscription_id = "2df97227-9b74-448e-8bc9-aa5cb23994ba"
}

provider "azurerm" {
  alias = "connectivity"

  features {}

  subscription_id = "237bd9d5-9158-404b-b798-ebd269d6f9ab"
}