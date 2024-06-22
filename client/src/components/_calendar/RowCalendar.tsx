import React from "react";

export default function RowCalendar() {
  return (
    <div className="flex items-center h-6 mt-4">
      <div>
        <button className="mr-4 mt-4"> 7:00</button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-neutral-200 mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-accent-500  mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-accent-500 mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-accent-500 mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-neutral-200 mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-neutral-200 mr-4 mt-4"></button>
      </div>
      <div>
        <button className="w-6 h-6 rounded-lg bg-accent-500 mr-4 mt-4"></button>
      </div>
    </div>
  );
}
