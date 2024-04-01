import { PropsWithChildren } from 'react';

export const Container = (props: PropsWithChildren) => {
  return <div className="container m-auto">{props.children}</div>;
};
