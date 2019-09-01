//+------------------------------------------------------------------+
//|                                                         HiLo.mq5 |
//|                                                   Rodrigo Morais |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "Rodrigo Morais"
#property link      ""
#property version   "1.00"
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
 int MyCalculator(int value,int value2) export
 {
    return(value+value2);
 }
//+------------------------------------------------------------------+

void getAveragePrice(double& sell,
                     double& buy,
                     const int periods,
                     const double &high[],
                     const double &low[],
                     const int current)
{
    for(int j = 0; j < periods; j++)
    {
       sell = sell + high[(current -1) - j] / periods;
       buy = buy + low[(current -1) - j] / periods;
    }
}

bool isUndefinedPosition(const double sell,
                       const double buy,
                       const double close)
{
  return(close >= buy && close <= sell);
} 

bool isToBuy(const double sell,
              const double close)
{
  return(close >= sell);
}

int draw(const int rates_total,
         const double &open[],
         const double &high[],
         const double &low[],
         const double &close[],
         const int periods,
         double& Superior[],
         double& Inferior[])
  {
   bool isPrevLo = true;

   ArrayResize(Inferior, rates_total);
   ArrayInitialize(Inferior, 0.0);
   ArrayResize(Superior, rates_total);
   ArrayInitialize(Superior, 0.0);
   
   for(int i=periods; i < rates_total; i++)
   {
      double sell = 0;
      double buy = 0;

      getAveragePrice(sell, buy, periods, high, low, i);

      Inferior[i] = 0;
      Superior[i] = 0;
      
      if (isUndefinedPosition(sell, buy,  close[i]))
      {
         if (isPrevLo) {
           Inferior[i] = buy;
         } else {
           Superior[i] = sell;
         }
      }
      else {
         if (isToBuy(sell, close[i])) {
            Inferior[i] = buy;
            isPrevLo = true;
         } else {
            Superior[i] = sell;
            isPrevLo = false;
         }
     }
   }
   return(rates_total);
  }
