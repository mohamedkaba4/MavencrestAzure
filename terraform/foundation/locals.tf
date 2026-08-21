locals {
  prefix = "mavencrest-${var.environment}"

  tags = {
    application = "mavencrest"
    environment = var.environment
    managed_by  = "terraform"
  }
}
