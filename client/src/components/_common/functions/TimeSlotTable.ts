import moment from 'moment';

export interface DaysOfWeek {
  [key: string]: string;
}

export type TimeSlotState = 'disabled' | 'available' | 'accepted' | 'rejected';

export const getInitialDays = (): DaysOfWeek => {
  const dayKeys = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  const engDayKeys = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const startOfWeek = moment().startOf('week');
  const days: DaysOfWeek = {};

  for (let i = 1; i <= 7; i++) {
    const dayDate = startOfWeek.clone().add(i, 'days').format('D/M');
    days[dayKeys[i - 1]] = dayDate;
  }

  return days;
};

export const generateTimeSlots = (
  startTime: string,
  endTime: string,
  interval: number,
): string[] => {
  const start = moment(startTime, 'H:mm');
  const end = moment(endTime, 'H:mm');
  const times: string[] = [];

  while (start < end) {
    times.push(
      start.format('H:mm') +
        ' - ' +
        start.add(interval, 'minutes').format('H:mm'),
    );
  }

  return times;
};

export const generateTimeSteps = (
  startTime: string,
  endTime: string,
  interval: number,
): string[] => {
  const start = moment(startTime, 'H:mm');
  const end = moment(endTime, 'H:mm');
  const times: string[] = [];

  while (start < end) {
    times.push(start.format('H:mm'));
    start.add(interval, 'minutes');
  }

  return times;
};

export const getRandomState = (): TimeSlotState => {
  const states: TimeSlotState[] = [
    'disabled',
    'available',
    'accepted',
    'rejected',
  ];
  return states[Math.floor(Math.random() * states.length)];
};
