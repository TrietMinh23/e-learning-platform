import React from "react";
import RowCalendar from "./RowCalendar";

export default function Calendar() {
  return (
    <div className="h-card rounded-large bg-accent-100    overflow-scroll  overflow-x-hidden  ">
      <div className="w-full">
        <div className="sticky top-0 bg-accent-100 ">
          <p className="font-bold text-lg left-6 pl-6 pt-6  ">Lịch tuần này</p>
          <div className="flex items-center mt-7  top-0 px-6   ">
            <p className="w-12 h-5  mr-4 opacity-0 pointer-events-none">7:00</p>
            <div className="flex-1 mr-4 h-5  ">
              <div className="w-6 h-5  text-center ">T2</div>
            </div>
            <div className="flex-1 mr-4  h-5 ">
              <div className="w-6  text-center">T3</div>
            </div>
            <div className="flex-1 mr-4 h-5  ">
              <div className="w-6  text-center">T4</div>
            </div>
            <div className="flex-1 mr-4  h-5 ">
              <div className="w-6  text-center">T5</div>
            </div>
            <div className="flex-1 mr-4 h-5  ">
              <div className="w-6  text-center">T6</div>
            </div>
            <div className="flex-1 mr-4  h-5 ">
              <div className="w-6 text-center">T7</div>
            </div>
            <div className="flex-1 mr-4  h-5 ">
              <div className="w-6 text-center">CN</div>
            </div>
          </div>
        </div>
        <div className="flex  flex-col  px-6    ">
          <div className="">
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
            <RowCalendar />
          </div>
        </div>
      </div>
      {/* <div className="font-bold text-lg">Lịch tuần này</div>
      <table className="">
        <thead>
          <tr>
            <td></td>
            <td>T2</td>
            <td>T3</td>
            <td>T4</td>
            <td>T5</td>
            <td>T6</td>
            <td>T7</td>
            <td>CN</td>
          </tr>
        </thead>
        <tbody className="mt-4">
          <RowCalendar />

          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
          <RowCalendar />
        </tbody>
      </table> */}
    </div>
  );
}
{
}
