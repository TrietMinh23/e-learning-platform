'use client';

import React from 'react';
import { DatePicker, Space } from 'antd';
import dayjs from 'dayjs';
import 'dayjs/locale/vi';
import locale from 'antd/es/date-picker/locale/vi_VN';
import styles from './styles/DatePickerComponent.module.scss';
import Calendar from '@public/icons/calendar.svg';
import Image from 'next/image';

const DatePickerComponent: React.FC = () => {
  return (
    <Space direction="vertical" size={12} className={``}>
      <div
        className={`${styles.picker} flex flex-row justify-end gap-3 items-center`}
      >
        <label className={`body-3 text-natural-700`}>Ngày</label>
        <DatePicker
          defaultValue={dayjs(dayjs(), 'YYYY-MM-DD')}
          format="DD/MM/YYYY"
          locale={locale}
          suffixIcon={
            <Image src={Calendar} alt="calendar" width={20} height={20} />
          }
          className={`w-[312px] body-4`}
        />
      </div>
    </Space>
  );
};

export default DatePickerComponent;
