﻿using LMS_Project.Logics;
using LMS_Project.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;

namespace LMS_Project.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            HomeLogics hl = new HomeLogics();
            UserLogics ul = new UserLogics();
            List<BookCategory> bcates = hl.GetAllBCate();
            List<User> auts = ul.GetAllAut();
            IEnumerable<Book> books1 = hl.GetTop4BLast();
            IEnumerable<Book> books2 = hl.GetTop4BBestBor();
            foreach (Book b in books1)
            {
                b.BPrice = (decimal?)((double)b.BPrice + (double)b.BPrice * 0.2);
            }
            foreach (Book b in books2)
            {
                b.BPrice = (decimal?)((double)b.BPrice + (double)b.BPrice * 0.2);
            }
            ViewBag.BCate = bcates;
            ViewBag.Aut = auts;
            ViewBag.Top4BLast = books1;
            ViewBag.Top4BBestBor = books2;
            return View("/Views/Index/Home.cshtml");
        }
        public IActionResult BookList(string bcid = "0", int autid = 0, int page = 1)
        {
            HomeLogics hl = new HomeLogics();
            UserLogics ul = new UserLogics();
            List<BookCategory> bcates = hl.GetAllBCate();
            List<User> auts = ul.GetAllAut();
            IEnumerable<Book> books = null;
            int numPerPage = 3, numPage = 0, size = 0, minisize = 0;
            if (!bcid.Equals("0") && autid != 0)
            {
                size = hl.GetAllBByBCateAutAct(bcid, autid).Count;
                numPage = size / numPerPage;
                if (size > 3 && numPage % 3 != 0 && size % 3 != 0) numPage += 1;
                else if (size > 0 && size <= 3) numPage = 1;
                books = hl.GetAllBByBCateAutAct(bcid, autid).Skip((int)(numPerPage * (page - 1))).Take(numPerPage);
            }
            else if (!bcid.Equals("0"))
            {
                size = hl.GetAllBByBCateIdAct(bcid).Count;
                numPage = size / numPerPage;
                if (size > 3 && numPage % 3 != 0 && size % 3 != 0) numPage += 1;
                else if (size > 0 && size <= 3) numPage = 1;
                books = hl.GetAllBByBCateIdAct(bcid).Skip((int)(numPerPage * (page - 1))).Take(numPerPage);
            }
            else if (autid != 0)
            {
                size = hl.GetAllBActByAutId(autid).Count;
                numPage = size / numPerPage;
                if (size > 3 && numPage % 3 != 0 && size % 3 != 0) numPage += 1;
                else if (size > 0 && size <= 3) numPage = 1;
                books = hl.GetAllBActByAutId(autid).Skip((int)(numPerPage * (page - 1))).Take(numPerPage);
            }
            else
            {
                size = hl.GetAllBAct().Count;
                numPage = size / numPerPage;
                if (size > 3 && numPage % 3 != 0 && size % 3 != 0) numPage += 1;
                else if (size > 0 && size <= 3) numPage = 1;
                books = hl.GetAllBAct().Skip((int)(numPerPage * (page - 1))).Take(numPerPage);
            }
            minisize = books.Count();
            foreach (Book b in books)
            {
                b.BPrice = (decimal?)((double)b.BPrice + (double)b.BPrice * 0.2);
            }
            ViewBag.BCate = bcates;
            ViewBag.Aut = auts;
            ViewBag.B = books;
            ViewBag.BCateCur = bcid;
            ViewBag.AutCur = autid;
            ViewBag.TotalSize = size;
            ViewBag.MiniSize = minisize;
            ViewBag.PageCur = page;
            ViewBag.NumPage = numPage;
            return View("/Views/Index/BookList.cshtml");
        }
        public IActionResult BookDetail(int bcid = 0)
        {
            HomeLogics hl = new HomeLogics();
            UserLogics ul = new UserLogics();
            List<BookCategory> bcates = hl.GetAllBCate();
            List<User> auts = ul.GetAllAut();
            Book book = hl.GetBookById(bcid);
            if (book != null)
            {
                book.BPrice = (decimal?)((double)book.BPrice + (double)book.BPrice * 0.2);
                List<Book> brelate = hl.GetAllBByBCateIdAct(book.BCateId);
                if (brelate.Contains(book)) brelate.Remove(book);
                foreach (Book b in brelate)
                {
                    b.BPrice = (decimal?)((double)b.BPrice + (double)b.BPrice * 0.2);
                }
                BookCategory bc = hl.GetBookCateById(book.BCateId);
                ViewBag.BCate = bcates;
                ViewBag.Aut = auts;
                ViewBag.BRelate = brelate;
                ViewBag.BCateCur = bc;
                ViewBag.Book = book;
            }
            return View("/Views/Index/BookDetail.cshtml");
        }
    }
}
