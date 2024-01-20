<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;


final class DefaultController extends AbstractController
{
    #[Route(
        path: '/',
        name: 'home'
    )]
    public function home(): Response
    {
        return $this->render('home/home.html.twig');
    }
}
