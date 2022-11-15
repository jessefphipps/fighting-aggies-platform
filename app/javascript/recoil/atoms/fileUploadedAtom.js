import {atom} from 'recoil';

export const fileUploadedAtom = atom({
  key: 'fileUploaded', // unique ID (with respect to other atoms/selectors)
  default: false, // default value (aka initial value)
});