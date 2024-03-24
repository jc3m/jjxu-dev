import { CollectionConfig } from 'payload/types';
import { RichTextBlock } from './RichTextBlock';

export const Posts: CollectionConfig = {
  slug: 'posts',
  fields: [
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'categories',
      admin: {
        position: 'sidebar',
      },
      hasMany: true,
      relationTo: 'categories',
      type: 'relationship',
    },
    {
      name: 'content',
      type: 'array',
      required: true,
      minRows: 1,
      fields: [
        {
          name: 'contentBlock',
          type: 'blocks',
          blocks: [RichTextBlock],
        },
      ],
    },
  ],
  admin: {
    useAsTitle: 'title',
  },
};
