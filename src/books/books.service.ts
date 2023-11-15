import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { Book } from './entities/book.entity';

@Injectable()
export class BooksService {
  constructor(
    @InjectRepository(Book) private readonly bookRepository: Repository<Book>,
  ) {}

  /**
   * this is function is used to create Book in Book Entity.
   * @param createBookDto this will type of createBookDto in which
   * we have defined what are the keys we are expecting from body
   * @returns promise of book
   */
  createBook(createBookDto: CreateBookDto): Promise<Book> {
    try {
      const isbn = createBookDto.isbn;
      // const check = this.findByISBN(isbn);
      // if (check) {
      //   throw new Error('This ISBN already exists');
      // }
      const book: Book = new Book();
      book.title = createBookDto.title;
      book.content = createBookDto.content;
      book.isbn = isbn;
      return this.bookRepository.save(book);
    } catch (error) {
      throw error;
    }
  }

  /**
   * this function is used to get all the Book's list
   * @returns promise of array of Books
   */
  findAllBook(): Promise<Book[]> {
    try {
      return this.bookRepository.find({ where: { deletedAt: null } });
    } catch (error) {
      throw error;
    }
  }

  /**
   * this function used to get data of use whose id is passed in parameter
   * @param id is type of number, which represent the id of Book.
   * @returns promise of Book
   */
  viewBook(id: number): Promise<Book> {
    try {
      return this.bookRepository.findOneBy({ id });
    } catch (error) {
      throw error;
    }
  }

  /**
   * this function is used to updated specific Book whose id is passed in
   * parameter along with passed updated data
   * @param id is type of number, which represent the id of Book.
   * @param updateBookDto this is partial type of createBookDto.
   * @returns promise of udpate Book
   */
  updateBook(id: number, updateBookDto: UpdateBookDto): Promise<Book> {
    try {
      const book: Book = new Book();
      book.title = updateBookDto.title;
      book.id = id;
      return this.bookRepository.save(book);
    } catch (error) {
      throw error;
    }
  }

  async softDelete(id: number): Promise<void> {
    try {
      const book = await this.bookRepository.findOneBy({ id });
      await this.bookRepository.softRemove(book);
    } catch (error) {
      throw error;
    }
  }
  async findByISBN(
    isbn: string,
    excludeId?: number,
  ): Promise<Book | undefined> {
    const queryBuilder = this.bookRepository.createQueryBuilder('book');
    queryBuilder.where('book.isbn = :isbn', { isbn });

    if (excludeId !== undefined) {
      queryBuilder.andWhere('book.id != :excludeId', { excludeId });
    }

    return queryBuilder.getOne();
  }
}
