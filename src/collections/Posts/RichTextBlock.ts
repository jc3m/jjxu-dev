import { Block } from 'payload/types';

export const RichTextBlock: Block = {
  slug: 'RichText', // required
  // imageURL: 'https://google.com/path/to/image.jpg',
  // imageAltText: 'A nice thumbnail image to show what this block looks like',
  // interfaceName: 'QuoteBlock', // optional
  fields: [
    {
      name: 'text',
      type: 'richText',
      required: true,
    },
  ],
};
