import { PropsWithChildren } from 'react';
import { concatClassNames } from 'utils/class-name';
import { Link as RouterLink } from 'react-router-dom';

const BASE_CLASSES = 'font-serif transition-colors underline font-bold';
const EXTERNAL_CLASSES = 'text-sky-500 hover:text-sky-300';
const INTERNAL_CLASSES = 'text-gray-200 hover:text-white';

interface Props {
  href: string;

  external?: boolean;

  className?: string;
}

const getColorClasses = (external: boolean) => {
  if (external) {
    return EXTERNAL_CLASSES;
  }

  return INTERNAL_CLASSES;
};

export const Link = (props: PropsWithChildren<Props>) => {
  const colorClasses = getColorClasses(!!props.external);
  const className = concatClassNames(
    BASE_CLASSES,
    colorClasses,
    props.className
  );

  if (props.external) {
    return (
      <a href={props.href} className={className}>
        {props.children}
      </a>
    );
  }

  return (
    <RouterLink to={props.href} className={className}>
      {props.children}
    </RouterLink>
  );
};
