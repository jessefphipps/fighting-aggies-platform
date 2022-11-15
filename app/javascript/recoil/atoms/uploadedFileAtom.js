import { atom } from 'recoil';

export const uploadedFileAtom = atom({
  key: 'uploadedFile',
  default: null,
})