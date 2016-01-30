investmentAPY <- 0.07
savingsInterestRate <- 0.0000995
depositsPerYear <- 24
investmentPercentage <- 1
savingsPercentage <- 0
dailySavings <- 1.5
inflation <- 1.025
years <- 20
startingYear <- 2016

moneyOnHand <- 0
savedMoney <- 0
investedMoney <- 0
cashReserve <- 0
depositDays <- seq(from = 1, to = 365 - floor(365 / depositsPerYear), by = floor(365 / depositsPerYear))
monthDays <- seq(from = 1, to = 365 - 30, by = 30)

yearlyAssets <- 0

for (y in 1:years) {
  
#   print(paste0("at year ",y))
#   
#   print(paste0("cash: ",cashReserve + moneyOnHand))
#   print(paste0("savings: ",savedMoney))
#   print(paste0("investments: ",investedMoney))
  
  for (i in 1:365) {
  
    moneyOnHand <- moneyOnHand + dailySavings
    
    if (i == 1) {
      investedMoney <- investedMoney*(1 + investmentAPY)
    }
    
    if (i %in% monthDays) {
      savedMoney <- savedMoney*(1 + savingsInterestRate)
    }
    
    if (i %in% depositDays) {
      savedMoney <- savedMoney + moneyOnHand*savingsPercentage
      investedMoney <- investedMoney + moneyOnHand*investmentPercentage
      cashReserve <- cashReserve + moneyOnHand*(1 - investmentPercentage - savingsPercentage)
      moneyOnHand <- 0
    }
  
  }
  
  yearlyAssets <- c(yearlyAssets,cashReserve + moneyOnHand + savedMoney + investedMoney)
  
}

investedMoney <- investedMoney*(1 + investmentAPY)
savedMoney <- savedMoney*(1 + savingsInterestRate)

assets <- (cashReserve + moneyOnHand + investedMoney + savedMoney)

print("final money:")
print(paste("cash:",(cashReserve + moneyOnHand),(cashReserve + moneyOnHand)*(1/inflation^years)))
print(paste("savings:",savedMoney,savedMoney*(1/inflation^years)))
print(paste("investments:",investedMoney,investedMoney*(1/inflation^years)))
print(paste("total assets:",assets,assets*(1/inflation^years)))

#plot 0:years against yearlyAssets