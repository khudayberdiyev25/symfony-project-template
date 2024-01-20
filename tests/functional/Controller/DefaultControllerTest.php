<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpFoundation\Response;

final class DefaultControllerTest extends WebTestCase
{
    public function testRedirectToLogin(): void
    {
        $client = static::createClient();
        $client->request('GET', '/');
        $this->assertEquals(
            Response::HTTP_FOUND,
            $client->getResponse()->getStatusCode()
        );

        $crawler = $client->followRedirect();
        $this->assertEquals(
            Response::HTTP_OK,
            $client->getResponse()->getStatusCode()
        );
        $this->assertStringEndsWith(
            '/login',
            $crawler->getUri(),
        );

        $client->submitForm('Login', [
            '_username' => 'admin@somemail.com',
            '_password' => 'admin123',
        ]);
        $crawler = $client->followRedirect();
        $this->assertEquals(
            Response::HTTP_OK,
            $client->getResponse()->getStatusCode()
        );
        $this->assertEquals(
            'Hello Symfony!!!',
            $crawler->filter('h1')->text()
        );
    }
}
