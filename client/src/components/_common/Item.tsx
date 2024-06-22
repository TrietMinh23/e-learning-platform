//
import React from 'react';
import Link from 'next/link';

interface ItemProps {
  metadata: {
    title: string;
    description: string;
    url: string;
  };
}

const mockData = {
  tile: 'Yeu cau chua duoc duyet',
  status: 'booking',
  url: 'url',
  description: '',
  data: {
    start: '05:00',
    end: '10:00',
    updatedAt: Date.now(),
    sportField: 'sportField',
    field: 'field3',
  },
};

const DotFrame: React.FC = () => {
  return <span className={`block w-1 h-1 rounded-lg bg-natural-300`}></span>;
};

const Item: React.FC = () => {
  const textColor = (status: string) => {
    switch (status) {
      case 'booking':
        return 'text-primary-600';
      case 'read':
        return 'text-natural-400';
      case 'reject':
        return 'text-alerts-red';
      default:
        return '';
    }
  };
  return (
    <>
      <div className={`flex flex-row gap-2 items-center`}>
        <Link
          href={mockData.url}
          className={`body-4 font-bold ${textColor(mockData.status)}`}
        >
          {mockData.tile}
        </Link>
        <DotFrame />
        <span className={`text-primary-600 body-5`}>2 giờ trước</span>
      </div>
      {mockData.description ? (
        <p className={`text-neutral-400 body-5`}>{mockData.description}</p>
      ) : (
        <div
          className={`body-5 flex flex-row gap-2 items-center text-natural-500`}
        >
          <p>{mockData.data.sportField}</p>
          <DotFrame />
          <p>
            {mockData.data.start} - {mockData.data.end}
          </p>
          <DotFrame />
          <p>{mockData.data.field}</p>
        </div>
      )}
    </>
  );
};

export default Item;
