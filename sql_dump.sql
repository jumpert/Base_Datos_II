PGDMP     3    #                {            obligatorio #   14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)    15.2 3    o           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            p           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            r           1262    16656    obligatorio    DATABASE     w   CREATE DATABASE obligatorio WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE obligatorio;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            s           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    4            t           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4            �            1259    16809    departamento    TABLE     P   CREATE TABLE public.departamento (
    nombre character varying(15) NOT NULL
);
     DROP TABLE public.departamento;
       public         heap    postgres    false    4            �            1259    16860    estado_necesidad    TABLE     T   CREATE TABLE public.estado_necesidad (
    nombre character varying(20) NOT NULL
);
 $   DROP TABLE public.estado_necesidad;
       public         heap    postgres    false    4            �            1259    16890    estado_postulacion    TABLE     V   CREATE TABLE public.estado_postulacion (
    nombre character varying(20) NOT NULL
);
 &   DROP TABLE public.estado_postulacion;
       public         heap    postgres    false    4            �            1259    16839 	   habilidad    TABLE     f   CREATE TABLE public.habilidad (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);
    DROP TABLE public.habilidad;
       public         heap    postgres    false    4            �            1259    16865 	   necesidad    TABLE     s  CREATE TABLE public.necesidad (
    id integer NOT NULL,
    ci_creador integer NOT NULL,
    descripcion character varying(500),
    estado character varying(20) NOT NULL,
    lat_ubicacion integer NOT NULL,
    long_ubicacion integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    fecha_solucionada date,
    titulo character varying(80) NOT NULL
);
    DROP TABLE public.necesidad;
       public         heap    postgres    false    4            �            1259    16875    necesidad_req_habilidad    TABLE     j   CREATE TABLE public.necesidad_req_habilidad (
    id_hab integer NOT NULL,
    id_nec integer NOT NULL
);
 +   DROP TABLE public.necesidad_req_habilidad;
       public         heap    postgres    false    4            �            1259    16916    notificacion    TABLE     �   CREATE TABLE public.notificacion (
    id integer NOT NULL,
    ci_usuario integer NOT NULL,
    mensaje character varying(100) NOT NULL,
    fecha date DEFAULT now() NOT NULL
);
     DROP TABLE public.notificacion;
       public         heap    postgres    false    4            �            1259    16895    postulacion    TABLE     �   CREATE TABLE public.postulacion (
    id_nec integer NOT NULL,
    ci_postulante integer NOT NULL,
    estado character varying(20) NOT NULL,
    fecha_creacion date DEFAULT now() NOT NULL
);
    DROP TABLE public.postulacion;
       public         heap    postgres    false    4            �            1259    16814    usuario    TABLE       CREATE TABLE public.usuario (
    ci integer NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20) NOT NULL,
    hashpwd character varying(64) NOT NULL,
    email character varying(40) NOT NULL,
    geo_dist integer DEFAULT 0 NOT NULL,
    geo_estado boolean DEFAULT false NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    ciudad character varying(20) NOT NULL,
    departamento character varying(15) NOT NULL,
    direccion character varying(50) NOT NULL,
    CONSTRAINT usuario_ci_check CHECK (((ci >= 0) AND (ci <= 99999999))),
    CONSTRAINT usuario_geo_dist_check CHECK ((geo_dist >= 0))
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    4            �            1259    16829    usuario_tel    TABLE     W   CREATE TABLE public.usuario_tel (
    ci integer NOT NULL,
    tel integer NOT NULL
);
    DROP TABLE public.usuario_tel;
       public         heap    postgres    false    4            �            1259    16844    usuario_tiene_habilidad    TABLE     �   CREATE TABLE public.usuario_tiene_habilidad (
    id_hab integer NOT NULL,
    ci integer NOT NULL,
    fecha_creacion date DEFAULT now() NOT NULL,
    descripcion character varying(100)
);
 +   DROP TABLE public.usuario_tiene_habilidad;
       public         heap    postgres    false    4            b          0    16809    departamento 
   TABLE DATA           .   COPY public.departamento (nombre) FROM stdin;
    public          postgres    false    209   n@       g          0    16860    estado_necesidad 
   TABLE DATA           2   COPY public.estado_necesidad (nombre) FROM stdin;
    public          postgres    false    214   �@       j          0    16890    estado_postulacion 
   TABLE DATA           4   COPY public.estado_postulacion (nombre) FROM stdin;
    public          postgres    false    217   �@       e          0    16839 	   habilidad 
   TABLE DATA           /   COPY public.habilidad (id, nombre) FROM stdin;
    public          postgres    false    212   �@       h          0    16865 	   necesidad 
   TABLE DATA           �   COPY public.necesidad (id, ci_creador, descripcion, estado, lat_ubicacion, long_ubicacion, fecha_inicio, fecha_fin, fecha_solucionada, titulo) FROM stdin;
    public          postgres    false    215   A       i          0    16875    necesidad_req_habilidad 
   TABLE DATA           A   COPY public.necesidad_req_habilidad (id_hab, id_nec) FROM stdin;
    public          postgres    false    216   A       l          0    16916    notificacion 
   TABLE DATA           F   COPY public.notificacion (id, ci_usuario, mensaje, fecha) FROM stdin;
    public          postgres    false    219   ;A       k          0    16895    postulacion 
   TABLE DATA           T   COPY public.postulacion (id_nec, ci_postulante, estado, fecha_creacion) FROM stdin;
    public          postgres    false    218   XA       c          0    16814    usuario 
   TABLE DATA           �   COPY public.usuario (ci, nombre, apellido, hashpwd, email, geo_dist, geo_estado, is_admin, ciudad, departamento, direccion) FROM stdin;
    public          postgres    false    210   uA       d          0    16829    usuario_tel 
   TABLE DATA           .   COPY public.usuario_tel (ci, tel) FROM stdin;
    public          postgres    false    211   �A       f          0    16844    usuario_tiene_habilidad 
   TABLE DATA           Z   COPY public.usuario_tiene_habilidad (id_hab, ci, fecha_creacion, descripcion) FROM stdin;
    public          postgres    false    213   B       �           2606    16813    departamento departamento_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (nombre);
 H   ALTER TABLE ONLY public.departamento DROP CONSTRAINT departamento_pkey;
       public            postgres    false    209            �           2606    16864 &   estado_necesidad estado_necesidad_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.estado_necesidad
    ADD CONSTRAINT estado_necesidad_pkey PRIMARY KEY (nombre);
 P   ALTER TABLE ONLY public.estado_necesidad DROP CONSTRAINT estado_necesidad_pkey;
       public            postgres    false    214            �           2606    16894 *   estado_postulacion estado_postulacion_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.estado_postulacion
    ADD CONSTRAINT estado_postulacion_pkey PRIMARY KEY (nombre);
 T   ALTER TABLE ONLY public.estado_postulacion DROP CONSTRAINT estado_postulacion_pkey;
       public            postgres    false    217            �           2606    16843    habilidad habilidad_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.habilidad
    ADD CONSTRAINT habilidad_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.habilidad DROP CONSTRAINT habilidad_pkey;
       public            postgres    false    212            �           2606    16869    necesidad necesidad_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.necesidad
    ADD CONSTRAINT necesidad_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.necesidad DROP CONSTRAINT necesidad_pkey;
       public            postgres    false    215            �           2606    16879 4   necesidad_req_habilidad necesidad_req_habilidad_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.necesidad_req_habilidad
    ADD CONSTRAINT necesidad_req_habilidad_pkey PRIMARY KEY (id_hab, id_nec);
 ^   ALTER TABLE ONLY public.necesidad_req_habilidad DROP CONSTRAINT necesidad_req_habilidad_pkey;
       public            postgres    false    216    216            �           2606    16921    notificacion notificacion_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.notificacion DROP CONSTRAINT notificacion_pkey;
       public            postgres    false    219            �           2606    16900    postulacion postulacion_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.postulacion
    ADD CONSTRAINT postulacion_pkey PRIMARY KEY (id_nec, ci_postulante);
 F   ALTER TABLE ONLY public.postulacion DROP CONSTRAINT postulacion_pkey;
       public            postgres    false    218    218            �           2606    16823    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (ci);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    210            �           2606    16833    usuario_tel usuario_tel_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.usuario_tel
    ADD CONSTRAINT usuario_tel_pkey PRIMARY KEY (ci, tel);
 F   ALTER TABLE ONLY public.usuario_tel DROP CONSTRAINT usuario_tel_pkey;
       public            postgres    false    211    211            �           2606    16849 4   usuario_tiene_habilidad usuario_tiene_habilidad_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.usuario_tiene_habilidad
    ADD CONSTRAINT usuario_tiene_habilidad_pkey PRIMARY KEY (id_hab, ci);
 ^   ALTER TABLE ONLY public.usuario_tiene_habilidad DROP CONSTRAINT usuario_tiene_habilidad_pkey;
       public            postgres    false    213    213            �           2606    16870    necesidad necesidad_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.necesidad
    ADD CONSTRAINT necesidad_estado_fkey FOREIGN KEY (estado) REFERENCES public.estado_necesidad(nombre);
 I   ALTER TABLE ONLY public.necesidad DROP CONSTRAINT necesidad_estado_fkey;
       public          postgres    false    214    215    3265            �           2606    16880 ;   necesidad_req_habilidad necesidad_req_habilidad_id_hab_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.necesidad_req_habilidad
    ADD CONSTRAINT necesidad_req_habilidad_id_hab_fkey FOREIGN KEY (id_hab) REFERENCES public.habilidad(id);
 e   ALTER TABLE ONLY public.necesidad_req_habilidad DROP CONSTRAINT necesidad_req_habilidad_id_hab_fkey;
       public          postgres    false    216    212    3261            �           2606    16885 ;   necesidad_req_habilidad necesidad_req_habilidad_id_nec_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.necesidad_req_habilidad
    ADD CONSTRAINT necesidad_req_habilidad_id_nec_fkey FOREIGN KEY (id_nec) REFERENCES public.necesidad(id);
 e   ALTER TABLE ONLY public.necesidad_req_habilidad DROP CONSTRAINT necesidad_req_habilidad_id_nec_fkey;
       public          postgres    false    216    3267    215            �           2606    16922 )   notificacion notificacion_ci_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_ci_usuario_fkey FOREIGN KEY (ci_usuario) REFERENCES public.usuario(ci);
 S   ALTER TABLE ONLY public.notificacion DROP CONSTRAINT notificacion_ci_usuario_fkey;
       public          postgres    false    210    3257    219            �           2606    16906 *   postulacion postulacion_ci_postulante_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.postulacion
    ADD CONSTRAINT postulacion_ci_postulante_fkey FOREIGN KEY (ci_postulante) REFERENCES public.usuario(ci);
 T   ALTER TABLE ONLY public.postulacion DROP CONSTRAINT postulacion_ci_postulante_fkey;
       public          postgres    false    210    218    3257            �           2606    16911 #   postulacion postulacion_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.postulacion
    ADD CONSTRAINT postulacion_estado_fkey FOREIGN KEY (estado) REFERENCES public.estado_postulacion(nombre);
 M   ALTER TABLE ONLY public.postulacion DROP CONSTRAINT postulacion_estado_fkey;
       public          postgres    false    3271    218    217            �           2606    16901 #   postulacion postulacion_id_nec_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.postulacion
    ADD CONSTRAINT postulacion_id_nec_fkey FOREIGN KEY (id_nec) REFERENCES public.necesidad(id);
 M   ALTER TABLE ONLY public.postulacion DROP CONSTRAINT postulacion_id_nec_fkey;
       public          postgres    false    218    3267    215            �           2606    16824 !   usuario usuario_departamento_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_departamento_fkey FOREIGN KEY (departamento) REFERENCES public.departamento(nombre);
 K   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_departamento_fkey;
       public          postgres    false    210    209    3255            �           2606    16834    usuario_tel usuario_tel_ci_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.usuario_tel
    ADD CONSTRAINT usuario_tel_ci_fkey FOREIGN KEY (ci) REFERENCES public.usuario(ci);
 I   ALTER TABLE ONLY public.usuario_tel DROP CONSTRAINT usuario_tel_ci_fkey;
       public          postgres    false    3257    211    210            �           2606    16855 7   usuario_tiene_habilidad usuario_tiene_habilidad_ci_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_tiene_habilidad
    ADD CONSTRAINT usuario_tiene_habilidad_ci_fkey FOREIGN KEY (ci) REFERENCES public.usuario(ci);
 a   ALTER TABLE ONLY public.usuario_tiene_habilidad DROP CONSTRAINT usuario_tiene_habilidad_ci_fkey;
       public          postgres    false    210    3257    213            �           2606    16850 ;   usuario_tiene_habilidad usuario_tiene_habilidad_id_hab_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_tiene_habilidad
    ADD CONSTRAINT usuario_tiene_habilidad_id_hab_fkey FOREIGN KEY (id_hab) REFERENCES public.habilidad(id);
 e   ALTER TABLE ONLY public.usuario_tiene_habilidad DROP CONSTRAINT usuario_tiene_habilidad_id_hab_fkey;
       public          postgres    false    213    212    3261            b      x��I,K��I�J����� )�?      g      x������ � �      j      x������ � �      e   "   x�3�tN,*��+I-�L�2��H-*3c���� ���      h      x������ � �      i      x������ � �      l      x������ � �      k      x������ � �      c   l   x�36� �<c�DcN�DC�H�RGG��DS}��<��$��LG�H� �Ȩ��|�4w/��@��4?��༤R�TcN�4 L6��I,K��I�J�L1����� �H�      d      x������ � �      f   0   x�3�4�N##c]3]CC�?.C�.���E�ə�y�\1z\\\ ���     