import { PropsWithChildren } from 'react';
import { Header } from './Header';

export const Layout = (props: PropsWithChildren) => {
  return (
    <div className="bg-neutral-900 min-h-screen">
      <Header />
      {props.children}
    </div>
  );
};
