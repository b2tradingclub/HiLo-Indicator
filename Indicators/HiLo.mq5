//+------------------------------------------------------------------+
//|                                                         Hilo.mq5 |
//|                                                          Rodrigo |
//|                                                                  |
//+------------------------------------------------------------------+

#include "../Libraries/HiLo.mq5"

#property copyright "Rodrigo Morais"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot Superior
#property indicator_label1  "Superior"
#property indicator_type1   DRAW_ARROW
#property indicator_color1  clrYellowGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  2
//--- plot Inferior
#property indicator_label2  "Inferior"
#property indicator_type2   DRAW_ARROW
#property indicator_color2  clrBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  2
//--- indicator buffers
double         Superior[];
double         Inferior[];

input int periods = 3;
input MEASUREMENT measurement = STANDARD;
input bool showData = false;

bool  isPrevLo    = true;

int OnInit()
  {
    SetIndexBuffer(0, Superior, INDICATOR_DATA);
    SetIndexBuffer(1, Inferior, INDICATOR_DATA);

    return(INIT_SUCCEEDED);
  }

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   char Comments[];
   draw(rates_total, prev_calculated, isPrevLo, open, high, low, close, measurement, periods, Superior,Inferior, Comments);

   if (showData) {
     Comment(CharArrayToString(Comments));
   }

   return(rates_total);
}
