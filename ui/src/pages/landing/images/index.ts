import Bangkok from './bangkok.jpg';
import BrooklynBridge from './brooklyn-bridge.jpg';
import Denver from './denver-union-stagion.jpg';
import EclipseT2 from './t2-manual.jpg';
import EclipseT3 from './third-contact-manual.jpg';
import Flower from './flower.jpg';
import Ranier from './mt-ranier.jpg';
import Yosemite from './yosemite.jpg';
import Zion from './zion.jpg';

interface Image {
  src: string;
  alt: string;
  date: Date;
}

export const images: Image[] = [
  {
    src: Bangkok,
    alt: 'Bangkok, Thailand',
    date: new Date('2023-05-30'),
  },
  {
    src: BrooklynBridge,
    alt: 'Brooklyn Bridge, New York City',
    date: new Date('2024-02-25'),
  },
  {
    src: Denver,
    alt: 'Union Station, Denver, Colorado',
    date: new Date('2022-01-11'),
  },
  {
    src: EclipseT2,
    alt: '2024 Eclipse, Carbondale, Illinois',
    date: new Date('2024-04-08'),
  },
  {
    src: EclipseT3,
    alt: '2024 Eclipse, Carbondale, Illinois',
    date: new Date('2024-04-08'),
  },
  {
    src: Flower,
    alt: 'Gardens by the Bay, Singapore',
    date: new Date('2023-06-10'),
  },
  {
    src: Ranier,
    alt: 'Mount Ranier, Washington',
    date: new Date('2023-09-18'),
  },
  {
    src: Yosemite,
    alt: 'Yosemite National Park, California',
    date: new Date('2022-11-04'),
  },
  {
    src: Zion,
    alt: 'Zion National Park, Utah',
    date: new Date('2022-02-19'),
  },
];
