import { PropsWithChildren } from 'react';
import { Link as RouterLink } from 'react-router-dom';

interface Props {
  href: string;
}

export const HeaderLink = (props: PropsWithChildren<Props>) => {
  return (
    <RouterLink
      to={props.href}
      className="font-serif text-gray-300 hover:text-white transition-colors underline"
    >
      {props.children}
    </RouterLink>
  );
};
