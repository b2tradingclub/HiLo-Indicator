//+------------------------------------------------------------------+
//|                                                     TestHiLo.mq5 |
//|                                                   Rodrigo Morais |
//+------------------------------------------------------------------+

#property copyright "Rodrigo Morais"
#property version   "1.00"

#include <UnitTest/UnitTest-Library.mqh>
#include "../../../Libraries/HiLo.mq5"

void OnStart(){
   CUnitTestsCollection utCollection("When Standard");

   utCollection.AddUnitTests(WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo(STANDARD));
   utCollection.AddUnitTests(WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo(STANDARD));
   utCollection.AddUnitTests(WhenCloseEqualThanHighMAShowsBuysSign(STANDARD));
   utCollection.AddUnitTests(WhenCloseSmallerThanHighMAShowsSellsSign(STANDARD));
   utCollection.AddUnitTests(WhenCloseEqualThanLowMAShowsBuysSign(STANDARD));
   utCollection.AddUnitTests(WhenCloseBiggerThanLowMAShowsBuysSign(STANDARD));
   utCollection.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign(STANDARD));
   utCollection.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign(STANDARD));

   CUnitTestsCollection utCollectionBody("When Body");

   utCollectionBody.AddUnitTests(WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo(BODY));
   utCollectionBody.AddUnitTests(WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo(BODY));
   utCollectionBody.AddUnitTests(WhenCloseEqualThanHighMAShowsBuysSign(BODY));
   utCollectionBody.AddUnitTests(WhenCloseSmallerThanHighMAShowsSellsSign(BODY));
   utCollectionBody.AddUnitTests(WhenCloseEqualThanLowMAShowsBuysSign(BODY));
   utCollectionBody.AddUnitTests(WhenCloseBiggerThanLowMAShowsBuysSign(BODY));
   utCollectionBody.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign(BODY));
   utCollectionBody.AddUnitTests(WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign(BODY));
}


CUnitTests* WhenNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndNumberOfCandlesSmallerThanPeriodsDoNotPresentHiLo");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[2] = {100,200};
   double high[2] = {120,220};
   double low[2] = {70,120};
   double close[2] = {110,190};

   draw(2, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[1], 0.0);
   ut.IsEquals(__FILE__, __LINE__, Superior[1], 0.0);
   return ut;
}

CUnitTests* WhenNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndNumberOfCandlesEqualThanPeriodsDoNotPresentHiLo");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[3] = {100,200,300};
   double high[3] = {120,220,340};
   double low[3] = {70,110,300};
   double close[3] = {120,190,330};

   draw(periods, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[2], 0.0);
   ut.IsEquals(__FILE__, __LINE__, Superior[2], 0.0);
   return ut;
}

CUnitTests* WhenCloseEqualThanHighMAShowsBuysSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndCloseEqualThanHighMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 80};
   double high[4] = {115,120,95,110};
   double low[4] = {70,75,50,55};
   double close[4] = {80,115,60,110};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = (low[0] + low[1] + low[2]) / 3;
   } else {
      expected = (close[0] + open[1] + close[2]) / 3;
   }

   draw(4, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseSmallerThanHighMAShowsSellsSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndCloseSmallerThanHighMAShowsSellsSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 80};
   double high[4] = {120,120,95,85};
   double low[4] = {70,75,50,55};
   double close[4] = {80,115,60,55};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = (high[0] + high[1] + high[2]) / 3;
   } else {
      expected = (open[0] + close[1] + open[2]) / 3;
   }

   draw(4, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], 0.0);
   ut.IsEquals(__FILE__, __LINE__, NormalizeDouble(Superior[3], 2), NormalizeDouble(expected, 2));
   return ut;
}

CUnitTests* WhenCloseEqualThanLowMAShowsBuysSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndCloseEqualThanLowMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 75, 90, 80};
   double high[4] = {115,120,95,110};
   double low[4] = {70,75,50,55};
   double close[4] = {70,115,50,65};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = (low[0] + low[1] + low[2]) / 3;
   } else {
      expected = (close[0] + open[1] + close[2]) / 3;
   }

   draw(4, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerThanLowMAShowsBuysSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndCloseBiggerThanLowMAShowsBuysSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[4] = {100, 90, 90, 100};
   double high[4] = {120,120,95,140};
   double low[4] = {70,75,50,95};
   double close[4] = {80,115,60,140};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = (low[0] + low[1] + low[2]) / 3;
   } else {
      expected = (close[0] + open[1] + close[2]) / 3;
   }

   draw(4, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, Inferior[3], expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[3], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerAndSmallerThanMAsShowsBuysPreviousSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "CloseBiggerAndSmallerThanMAsShowsBuysPreviousSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[5] = {100, 90, 90, 100, 90};
   double high[5] = {120,120,95,140, 95};
   double low[5] = {70,75,50,95, 85};
   double close[5] = {80,115,60,140, 90};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = NormalizeDouble((low[1] + low[2] + low[3]) / 3, 2);
   } else {
      expected = NormalizeDouble((open[1] + close[2] + open[3]) / 3, 2);
   }

   draw(5, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, NormalizeDouble(Inferior[4] ,2), expected);
   ut.IsEquals(__FILE__, __LINE__, Superior[4], 0.0);
   return ut;
}

CUnitTests* WhenCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign(MEASUREMENT measurement){
   CUnitTests* ut = new CUnitTests("When" + EnumToString(measurement) + "AndCloseBiggerAndSmallerThanMAsShowsSellsPreviousSign");

   int periods = 3;
   double Superior[];
   double Inferior[];
   double open[5] = {100, 90, 90, 80, 100};
   double high[5] = {120,120,95,85, 120};
   double low[5] = {70,75,50,55, 80};
   double close[5] = {80,115,60,55, 90};
   double expected = 0;
   if (measurement == STANDARD) {
      expected = NormalizeDouble((high[1] + high[2] + high[3]) / 3, 2);
   } else {
      expected = NormalizeDouble((close[1] + open[2] + open[3]) / 3, 2);
   }

   draw(5, open, high, low, close, measurement, periods, Superior, Inferior);

   ut.IsEquals(__FILE__, __LINE__, NormalizeDouble(Superior[4] ,2), expected);
   ut.IsEquals(__FILE__, __LINE__, Inferior[4], 0.0);
   return ut;
}
