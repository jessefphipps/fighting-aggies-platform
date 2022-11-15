import { atom } from 'recoil';

export const selectedFileAtom = atom({
  key: 'selectedFile',
  default: null,
})