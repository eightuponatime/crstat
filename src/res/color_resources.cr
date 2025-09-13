module Resources::Color
  # cpu smi color resources
  RESET          = "\e[0m"
  USER_CLR       = "\e[38;2;173;216;230m" # #add8e6
  NICE_CLR       = "\e[38;5;33m"          # #0066ff
  SYSTEM_CLR     = "\e[38;2;177;38;104m"  # #b12668
  IRQ_CLR        = "\e[38;2;250;189;47m"  # #fabd2f
  SOFTIRQ_CLR    = "\e[38;2;152;151;26m"  # #98971a
  STEAL_CLR      = "\e[38;2;66;123;88m"   # #427b58
  GUEST_CLR      = "\e[38;2;7;102;120m"   # #076678
  GUEST_NICE_CLR = "\e[38;2;146;131;116m" # #928374
end
