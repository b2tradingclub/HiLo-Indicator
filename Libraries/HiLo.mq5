//+------------------------------------------------------------------+
//|                                                         HiLo.mq5 |
//|                                                   Rodrigo Morais |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "Rodrigo Morais"
#property link      ""
#property version   "1.00"

enum MEASUREMENT{
  STANDARD, // Standard
  BODY      // Body
};

void getAveragePrice(double& sell,
                     double& buy,
                     const int periods,
                     const double &high[],
                     const double &low[],
                     const double &open[],
                     const double &close[],
                     const MEASUREMENT measurement,
                     const int current)
{
    if(measurement == STANDARD) {
      for(int j = 0; j < periods; j++)
      {
         sell = sell + high[(current -1) - j] / periods;
         buy = buy + low[(current -1) - j] / periods;
      }
    } else {
      for(int j = 0; j < periods; j++)
      {
        if(open[(current -1) - j] >= close[(current -1) - j]) {
          sell = sell + open[(current -1) - j] / periods;
          buy = buy + close[(current -1) - j] / periods;
        } else {
          sell = sell + close[(current -1) - j] / periods;
          buy = buy + open[(current -1) - j] / periods;
        }
      }
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

void drawCandle(double sell,
                double buy,
                double close,
                bool &isPrevLo,
                double& Superior,
                double& Inferior)
{
  if (isUndefinedPosition(sell, buy,  close))
  {
     if (isPrevLo) {
       Inferior = buy;
     } else {
       Superior = sell;
     }
  }
  else {
     if (isToBuy(sell, close)) {
        Inferior = buy;
        isPrevLo = true;
     } else {
        Superior = sell;
        isPrevLo = false;
     }
 }
}

void draw(const int rates_total,
       const int prev_calculated,
       bool& isPrevLo,
       const double &open[],
       const double &high[],
       const double &low[],
       const double &close[],
       const MEASUREMENT measurement,
       const int periods,
       double& Superior[],
       double& Inferior[])
{
  if (prev_calculated == 0) {
    for(int i=periods; i < rates_total; i++)
    {
      double sell = 0;
      double buy = 0;

      getAveragePrice(sell, buy, periods, high, low, open, close, measurement, i);

      Inferior[i] = 0;
      Superior[i] = 0;
 
      drawCandle(sell, buy, close[i], isPrevLo, Superior[i], Inferior[i]);
    }
  } else {
      double sell = 0;
      double buy = 0;
      int current = rates_total - 1;

      getAveragePrice(sell, buy, periods, high, low, open, close, measurement, current);

      Inferior[current] = 0;
      Superior[current] = 0;
 
      drawCandle(sell, buy, close[current], isPrevLo, Superior[current], Inferior[current]);
  }
}
