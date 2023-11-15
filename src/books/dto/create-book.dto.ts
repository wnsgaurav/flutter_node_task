import { IsNotEmpty, IsString, MinLength, IsISBN } from 'class-validator';

export class CreateBookDto {
  @IsString()
  @MinLength(2, { message: 'Title must have atleast 2 characters.' })
  @IsNotEmpty()
  title: string;

  @IsNotEmpty()
  @MinLength(2, { message: 'isbn must have atleast 2 characters.' })
  @IsISBN()
  isbn: string;

  @IsNotEmpty()
  content: string;
}
