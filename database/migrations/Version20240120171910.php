<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240120171910 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        $sql = <<<'SQL'

            CREATE TABLE IF NOT EXISTS "tmp_user" (
                "id" UUID NOT NULL,
                "name" varchar(128) NOT NULL,
                "username" varchar(128) NOT NULL,
                "password_hash" varchar(255) NOT NULL,
                "created_at" integer NOT NULL,
                "updated_at" integer DEFAULT NULL,
                "last_login_at" integer DEFAULT NULL,
                PRIMARY KEY ("id"),
                UNIQUE ("username")
            );
SQL;

        $this->addSql($sql);
    }

    public function down(Schema $schema): void
    {
        $schema->dropTable('tmp_user');
    }
}
