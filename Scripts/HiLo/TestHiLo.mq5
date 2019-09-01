//+------------------------------------------------------------------+
//|                                                     TestHiLo.mq5 |
//|                                                   Rodrigo Morais |
//+------------------------------------------------------------------+

#property copyright "Rodrigo Morais"
#property version   "1.00"

#include <UnitTest/UnitTest-Library.mqh>
#include "../../../Libraries/HiLo.mq5"

void OnStart(){
   CUnitTestsCollection utCollection();

   utCollection.AddUnitTests(WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo());
   utCollection.AddUnitTests(WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo());
   utCollection.AddUnitTests(WhenCloseEqualThanHighMAShowsBuysSign());
   utCollection.AddUnitTests(WhenCloseSmallerThanHighMAShowsSellsSign());
   utCollection.AddUnitTests(WhenCloseEqualThanLowMAShowsBuysSign());
   utCollection.AddUnitTests(WhenCloseBiggerThanLowMAShowsBuysSign());
   utCollection.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign());
   utCollection.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign());
}


CUnitTests* WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo(){
   CUnitTests* ut = new CUnitTests("WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[2] = {100,200};
   double high[2] = {120,220};
   double low[2] = {70,120};
   double close[2] = {110,190};

   draw(2, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[1], 0.0);
   ut.IsEquals(__FILE__, __LINE__, Superior[1], 0.0);
   return ut;
}

CUnitTests* WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo(){
   CUnitTests* ut = new CUnitTests("WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[3] = {100,200,300};
   double high[3] = {120,220,340};
   double low[3] = {70,110,300};
   double close[3] = {120,190,330};

   draw(periods, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[2], 0.0);
   ut.IsEquals(__FILE__, __LINE__, Superior[2], 0.0);
   return ut;
}

CUnitTests* WhenCloseEqualThanHighMAShowsBuysSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseEqualThanHighMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 80};
   double high[4] = {115,120,95,110};
   double low[4] = {70,75,50,55};
   double close[4] = {80,115,60,110};
   double expected = (low[0] + low[1] + low[2]) / 3;

   draw(4, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseSmallerThanHighMAShowsSellsSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseSmallerThanHighMAShowsSellsSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 80};
   double high[4] = {120,120,95,85};
   double low[4] = {70,75,50,55};
   double close[4] = {80,115,60,55};
   double expected = (high[0] + high[1] + high[2]) / 3;

   draw(4, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], 0.0);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], expected);
   return ut;
}

CUnitTests* WhenCloseEqualThanLowMAShowsBuysSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseEqualThanLowMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 80};
   double high[4] = {115,120,95,110};
   double low[4] = {70,75,50,55};
   double close[4] = {80,115,60,65};
   double expected = (low[0] + low[1] + low[2]) / 3;

   draw(4, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerThanLowMAShowsBuysSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseBiggerThanLowMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 100};
   double high[4] = {120,120,95,140};
   double low[4] = {70,75,50,95};
   double close[4] = {80,115,60,140};
   double expected = (low[0] + low[1] + low[2]) / 3;

   draw(4, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[5] = {100, 90, 90, 100, 90};
   double high[5] = {120,120,95,140, 95};
   double low[5] = {70,75,50,95, 85};
   double close[5] = {80,115,60,140, 90};
   double expected = NormalizeDouble((low[1] + low[2] + low[3]) / 3, 2);

   draw(5, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, NormalizeDouble(Inferior[4] ,2), expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[4], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign(){
   CUnitTests* ut = new CUnitTests("WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[5] = {100, 90, 90, 80, 100};
   double high[5] = {120,120,95,85, 120};
   double low[5] = {70,75,50,55, 80};
   double close[5] = {80,115,60,55, 90};
   double expected = NormalizeDouble((high[1] + high[2] + high[3]) / 3, 2);

   draw(5, open, high, low, close, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, NormalizeDouble(Superior[4] ,2), expected);
   ut.IsEquals(__FILE__, __LINE__, Inferior[4], 0.0);
   return ut;
}
