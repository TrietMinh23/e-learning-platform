//
import React from 'react';
import { Button } from 'antd';
import styles from '../styles/AccentButton.module.scss';

interface AccentButtonProps {
  label: string;
  value: string;
  isActive: boolean;
  onClick: (value: string) => void;
  style?: string | '';
}

const AccentButton: React.FC<AccentButtonProps> = ({
  label,
  value,
  isActive,
  onClick,
  style,
}) => {
  return (
    <div className={`${styles.buttonContainer} ${style}`}>
      <Button
        type={isActive ? 'primary' : 'default'}
        onClick={() => onClick(value)}
        className={`${style} w-full`}
      >
        {label}
      </Button>
    </div>
  );
};

export default AccentButton;
