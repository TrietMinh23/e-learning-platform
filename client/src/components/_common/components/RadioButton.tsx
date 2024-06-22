import React from 'react';
import { Button } from 'antd';
import styles from '../styles/RadioButton.module.scss';

interface RadioBtnProps {
  label?: string;
  value: string;
  isActive: string;
  onClick: (value: string) => void;
}

const RadioBtn: React.FC<RadioBtnProps> = ({
  label,
  value,
  isActive,
  onClick,
}) => {
  return (
    <button
      onClick={() => onClick(value)}
      className={`flex flex-row gap-3 items-center`}
    >
      <div className={`relative`}>
        <span
          className={`block w-6 h-6 rounded-3xl border-2 border-neutral-200 relative`}
        ></span>
        {isActive === value && (
          <span
            className={`block absolute top-1 left-1 w-4 h-4 rounded-3xl bg-primary-600`}
          ></span>
        )}
      </div>
      {label && <span className="body-3 text-natural-700">{label}</span>}
    </button>
  );
};

export default RadioBtn;
